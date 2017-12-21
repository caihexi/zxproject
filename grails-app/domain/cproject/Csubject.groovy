package cproject

import java.io.ObjectInputStream.ValidationList;

import sun.tools.tree.ThisExpression;

/************
 * 科目
 */
class Csubject {
	Integer subjectType=0
	String subjectName=""
	Csubject subjectParent
	BigDecimal subjectBalance=0
	Boolean deleted=false
	

    static constraints = {
		subjectType(inList:[1,2,3]);
		subjectName(unique:true)
		subjectParent(nullable:false) 
		subjectBalance()   
    }
	
	String toString() {
		return this.subjectName;
	};

}
