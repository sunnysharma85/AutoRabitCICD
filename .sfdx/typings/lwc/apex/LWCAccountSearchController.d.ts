declare module "@salesforce/apex/LWCAccountSearchController.getAccountsContacts" {
  export default function getAccountsContacts(param: {idAccount: any}): Promise<any>;
}
declare module "@salesforce/apex/LWCAccountSearchController.getAccounts" {
  export default function getAccounts(param: {accountName: any, accountIndustry: any}): Promise<any>;
}
declare module "@salesforce/apex/LWCAccountSearchController.getContactCountForAccount" {
  export default function getContactCountForAccount(param: {idAccount: any}): Promise<any>;
}
