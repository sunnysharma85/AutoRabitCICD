public class pdfGenerationClass {
	@future(callout=true)
	public static void GetData() {        
		string RequestURL = '';    
		string ResponseString = '';             
		HttpRequest Request = new HttpRequest();        
		Http DataHttp = new Http();                 
		Request.setMethod('GET');                 
		RequestURL = 'http://www.pdf995.com/samples/pdf.pdf' ;
		Request.setEndpoint(RequestURL);                                 
		HttpResponse DataResponse = DataHttp.send(Request);        
		ResponseString = DataResponse.getBody(); 
        system.debug('ResponseString ---->' + ResponseString);
		Blob ResponseAsBlob = blob.valueof(ResponseString);        
		attachment DataFile = new attachment();        
		DataFile.Name = 'Data_New.pdf';        
		DataFile.ParentId = '00146000003m20TAAQ';                                    
		DataFile.body = ResponseAsBlob;                        
		insert DataFile;                            
	} 	
}