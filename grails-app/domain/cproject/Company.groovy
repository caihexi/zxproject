package cproject

import sun.tools.tree.ThisExpression;

import com.sun.org.apache.bcel.internal.generic.RETURN;

/******************
 * 供应商
 */
class Company {
	String companyName=""
	String companyAddress=""
	String companyTelphone=""
	String memo=""
	Boolean deleted=false

    static constraints = {
    	companyName(nullable:false,unique:true);
    	companyAddress(nullable:false);
    	companyTelphone(nullable:false);
    	memo(nullable:false);
    }
	
	String toString() {
		return this.companyName
	}
}
