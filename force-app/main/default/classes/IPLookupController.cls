public class IPLookupController {
	public void fetchIPDetails(){
		//tempuriOrg.DNSSoap objtempuriOrgDNSSoap = new tempuriOrg.DNSSoap();
		tempuriOrg.DNSSoap dns = new tempuriOrg.DNSSoap();
		
  		// Set up the license header
  		dns.LicenseInfo = new wsStrikeironCom.LicenseInfo();
  		dns.LicenseInfo.RegisteredUser = new wsStrikeironCom.RegisteredUser();
  		dns.LicenseInfo.RegisteredUser.UserID = 'sunny.sharma85@gmail.com';
  		dns.LicenseInfo.RegisteredUser.Password = 'b36CfW';
  		// Make the Web service call
  		tempuriOrg.DNSInfo info = dns.DNSLookup('www.google.com');
  		System.debug(info);
  		string ipaddress = info.AddressList.string_x[0];
  		system.debug(ipaddress);
	}
}