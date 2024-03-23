import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "errorMsg",
    "signature",
    "ens",
    "message",
  ]

  getCSRF () {
    return document.querySelector('meta[name="csrf-token"]').content;
  }

  async signIn(e) {
    this.errorMsgTarget.classList.add("hidden")

    const metamask = window.ethereum;

    if (typeof metamask == 'undefined') {
      this.showError("Please install Metamask extension first.")
      return
    }

    await metamask.request({
      method: 'eth_requestAccounts',
    });
    const provider = new ethers.providers.Web3Provider(metamask);


    const [address] = await provider.listAccounts();
    if (!address) {
      this.showError("Address not found.")
    }

    /**
       * Try to resolve address ENS and updates the title accordingly.
    */
    try {
      this.ensTarget.value = await provider.lookupAddress(address);
    } catch (error) {
      console.error(error);
    }

    let { chainId } = await provider.getNetwork();

    /**
       * Gets the proper message from our backend
    */
    const message = await fetch('/message',
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': this.getCSRF(),
        },
        credentials: 'include',
        body: JSON.stringify({
          chainId,
          address,
        })
      }).then((res) => res.text());

    this.messageTarget.value = message;
    /**
       * Asks for the provider to sign our fresh message
    */
    try {
      this.signatureTarget.value = await provider.getSigner().signMessage(message);
    } catch (error) {
      this.showError("Signature rejected")
      return
    }
    /**
       * Calls our sign_in endpoint to validate the message, if successful it will
       * save the message in the session and allow the user to store his text
    */
    e.target.closest("form").requestSubmit();
  }

  showError(msg) {
    this.errorMsgTarget.classList.remove("hidden")
    this.errorMsgTarget.innerText = msg;
  }
}
