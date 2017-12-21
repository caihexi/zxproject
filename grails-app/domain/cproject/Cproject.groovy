package cproject
/*************
 * 项目
 */
class Cproject {
	String projectName=""
	Boolean deleted=false
	
    static constraints = {
    	projectName(nullable:false,unique:true);
    }
	
	@Override
	public String toString() {
		return this.projectName;
	}
	
}

