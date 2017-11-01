window.onGoogleYoloLoad = (googleyolo) => {
  const clientId = document.getElementById('clientId').getAttribute('value')
  const authHash = {
    supportedAuthMethods: [
      "https://accounts.google.com"
    ],
    supportedIdTokenProviders: [
      {
        uri: "https://accounts.google.com",
        clientId: clientId
      }
    ]
  }
  googleyolo.retrieve(authHash).then((credential) => {
    console.log(credential)
  }).catch((e) => {
    if(e.type === 'noCredentialsAvailable') {
      googleyolo.hint(authHash).then((credential) => {
        console.log(credential);
        console.log(credential.idToken);
        if(credential.idToken) {
          $.ajax({
            type: "GET",
            url: "/users/" + credential.idToken + "/verify"
          })
        }
      })
    }
  });
};
