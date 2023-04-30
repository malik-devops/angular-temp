// This file can be replaced during build by using the `fileReplacements` array.
// `ng build --prod` replaces `environment.ts` with `environment.prod.ts`.
// The list of file replacements can be found in `angular.json`.
const apiUrl =  '';
const notificationUrl = '';
const clientID = '';

export const environment = {
  production: true,
  local: false,
  apiBaseURL: apiUrl,
  clientID,
  firebaseConfig: {
  }
};
