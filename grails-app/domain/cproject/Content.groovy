package cproject
/********
 * 联系人
 */
class Content {
	String personName
	Company company
	String personAddress
	String personPhone
	Date personBirthday
	String personMemo
	

    static constraints = {
    	personName(nullable:false,unique:true)
    	company(nullable:true)
    	personAddress(nullabe:true);
    	personPhone(nullable:true);
    	personBirthday(nullable:true);
    	personMemo(nullable:true);
    }
}
