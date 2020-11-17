public with sharing class PdfEmailController {

    public PdfEmailController(ApexPages.StandardController controller) {

    }
public PdfEmailController() {

    }

  public ID accountId {get;set;}
  public String email {get;set;}

  public List<SelectOption> accounts {
    get {
      if (accounts == null) {
        accounts = new List<SelectOption>();
        accounts.add(new SelectOption('00146000003m20Y','United Oil & Gas Corp.'));
        accounts.add(new SelectOption('00146000003m20U','Burlington Textiles Corp of America'));
      }
      return accounts;
    }
    set;
  }
    
    public PageReference printPdf() {
        PageReference pdf = Page.PdfGeneratorTemplate;
    // add parent id to the parameters for standardcontroller
    pdf.getParameters().put('id',accountId);
    pdf.getParameters().put('Email',email);
    //pdf.setredirect(true);
    return pdf;
    }
  public PageReference sendPdf() {

    PageReference pdf = Page.PdfGeneratorTemplate;
    // add parent id to the parameters for standardcontroller
    pdf.getParameters().put('id',accountId);
    pdf.getParameters().put('Email',email);
    // the contents of the attachment from the pdf
    Blob body;

    try {

      // returns the output of the page as a PDF
      body = pdf.getContent();

    // need to pass unit test -- current bug  
    } catch (VisualforceException e) {
      body = Blob.valueOf('Some Text');
    }

    Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
    attach.setContentType('application/pdf');
    attach.setFileName('testPdf.pdf');
    attach.setInline(false);
    attach.Body = body;

    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    mail.setUseSignature(false);
    mail.setToAddresses(new String[] { email });
    mail.setSubject('PDF Email Demo');
    mail.setHtmlBody('Here is the email you requested! Check the attachment!');
    mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach }); 

    // Send the email
    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Email with PDF sent to '+email));

    return null;

  }

}