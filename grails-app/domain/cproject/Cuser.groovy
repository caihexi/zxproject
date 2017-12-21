package cproject

import sun.tools.tree.ThisExpression;

import com.sun.org.apache.bcel.internal.generic.RETURN;

/*************
 * 用户
 */
class Cuser {
	String userName
	String login
	String userPassword
	String userRole
	Integer status=1

    static constraints = {
		userName(nullable:false)
		login(nullable:false,unique:true)
		userPassword(nullable:false)
		userRole(nullable:true)
		status(inList:[0,1]);
    }
	
	String toString() {
		return userName;
	};

	String roleName() {
		StringBuffer result = new StringBuffer();
		this.userRole.split(",").each() { String r->
			result.append(roleName(r)).append(",")
		}
		if (result.length()>0) {
			result.deleteCharAt(result.length()-1)
		}
		return result.toString();
	}

	static String roleName(String role) {
		switch(role) {
			case "user" : return "人事主管"
			case "account" : return "会计主管"
			case "project" : return "项目主管"
			case "content" : return "客户主管"
			case "admin": return "系统主管"
			default : return null
		}
	}
	
}
