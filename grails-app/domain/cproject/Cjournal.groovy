package cproject


import java.util.Date;

import org.codehaus.groovy.grails.plugins.web.taglib.ValidationTagLib

import sun.tools.tree.ThisExpression;

/*************
 * 日记账
 *************/
class Cjournal {
	Date journalDate = new Date(); //交易日期
	Csubject subject0
    Integer journalType = 1  //交易类型 1=收入 -1=支出
    BigDecimal amount
	//Csubject subject1
	Cproject projecti
	Company company
    Cuser inputMan
	String memo
	BigDecimal subject0Balance=0
	//BigDecimal subject1Balance=0
	

    static constraints = {
		journalDate(nullable:false)
        journalType(nullable:false,inList:[-1,1])
		//journalType(nullable:false,inList:[1,2,3])
		subject0(nullable:false)
		//subject1(nullable:false)
		projecti(nullable:false)
		amount(nullable:false,min:0.00)
		inputMan(nullable:false)
		company(nullable:false)
		memo(nullable:true)
    }
	
	/**
	 * 计算相关科目的余额
	 * 并更新科目余额
	 * @author 蔡贺曦
	 * @create 2013.11.25
     * @update 2017.12.9 改为简单记账
	 */
	def mycalc = {
        subject0Balance=subject0.subjectBalance + amount*journalType;
        subject0.subjectBalance = subject0Balance;
        subject0.save(flush:true);
        return this.save(flush:true);

        /*
		switch (journalType) {
			case 1:  //收入
				subject0Balance=subject0.subjectBalance+amount;
				subject0.subjectBalance = subject0Balance;
				subject0.save(flush:true);
				subject1Balance=subject1.subjectBalance+amount;
				subject1.subjectBalance = subject1Balance;
				subject1.save(flush:true);
				return this.save(flush:true);
			
			break;
			case 2://支出
				subject0Balance=subject0.subjectBalance-amount;
				subject0.subjectBalance = subject0Balance;
				subject0.save(flush:true);
				subject1Balance=subject1.subjectBalance-amount;
				subject1.subjectBalance = subject1Balance;
				subject1.save(flush:true);
				return this.save(flush:true);
			break;
			case 3:
				subject0Balance=subject0.subjectBalance+amount;
				subject0.subjectBalance = subject0Balance;
				subject0.save(flush:true);
				subject1Balance=subject1.subjectBalance-amount;
				subject1.subjectBalance = subject1Balance;
				subject1.save(flush:true);
				return this.save(flush:true);
			break;
			default:
			return null;
		}
		*/
	}
	
	/**
	 * 重新计算各科目的余额
	 * 以及各流水记账后的余额
	 * @author 蔡贺曦
	 * @create 2013.11.26
     * @update 2017.12.9 改为简单记账
	 */
	def static mycalcAll = {
		Csubject.list().each{ Csubject sInstance->
			sInstance.subjectBalance = 0;//清零
		}
		Cjournal.list(['sort':'journalDate']).each(){ Cjournal jInstance->
            jInstance.subject0Balance=jInstance.subject0.subjectBalance+jInstance.amount*jInstance.journalType;
            if(jInstance.subject0.subjectBalance != jInstance.subject0Balance) {
                jInstance.subject0.subjectBalance = jInstance.subject0Balance;
                jInstance.save();
            }


            /*
			switch (jInstance.journalType) {
			case 1:
				jInstance.subject0Balance=jInstance.subject0.subjectBalance+jInstance.amount;
				jInstance.subject1Balance=jInstance.subject1.subjectBalance+jInstance.amount;
				if(jInstance.subject0.subjectBalance != jInstance.subject0Balance) {
					jInstance.subject0.subjectBalance = jInstance.subject0Balance;
					jInstance.save();
				}
				if(jInstance.subject1.subjectBalance != jInstance.subject1Balance) {
					jInstance.subject1.subjectBalance = jInstance.subject1Balance;
					jInstance.save();
				}
			break;
			case 2:
				jInstance.subject0Balance=jInstance.subject0.subjectBalance-jInstance.amount;
				jInstance.subject1Balance=jInstance.subject1.subjectBalance-jInstance.amount;
				if(jInstance.subject0.subjectBalance != jInstance.subject0Balance) {
					jInstance.subject0.subjectBalance = jInstance.subject0Balance;
					jInstance.save();
				}
				if(jInstance.subject1.subjectBalance != jInstance.subject1Balance) {
					jInstance.subject1.subjectBalance = jInstance.subject1Balance;
					jInstance.save();
				}
			break;
			case 3:
				jInstance.subject0Balance=jInstance.subject0.subjectBalance+jInstance.amount;
				jInstance.subject1Balance=jInstance.subject1.subjectBalance-jInstance.amount;
				if(jInstance.subject0.subjectBalance != jInstance.subject0Balance) {
					jInstance.subject0.subjectBalance = jInstance.subject0Balance;
					jInstance.save();
				}
				if(jInstance.subject1.subjectBalance != jInstance.subject1Balance) {
					jInstance.subject1.subjectBalance = jInstance.subject1Balance;
					jInstance.save();
				}
			break;
			}//endswitch*/
		}//endeach
		Csubject.list().each{ Csubject sInstance->
			sInstance.save(flush:true);//保存
		}
	}
	
	public static String csvTitle() {
		def g = new ValidationTagLib();
		  return("ID,"
		+g.message(code: "cjournal.journalDate.label", default: "未知") + ","
        +g.message(code: "cjournal.subject0.label", default: "未知") + ","
		+g.message(code: "cjournal.journalType.label", default: "未知") + ","
        +g.message(code: "cjournal.amount.label", default: "未知") + ","
//		+g.message(code: "cjournal.subject1.label", default: "未知") + ","
		+g.message(code: "cjournal.projecti.label", default: "未知") + ","
		+g.message(code: "cjournal.company.label", default: "未知") + ","
		+g.message(code: "cjournal.subject0Balance.label", default: "未知") + ","
        +g.message(code: "cjournal.inputMan.label", default: "未知") + ","
                  +g.message(code: "cjournal.memo.label", default: "未知") //+ ","
//		+g.message(code: "cjournal.subject1Balance.label", default: "未知")
                  + "\r\n")
		}
		
	
	String csvLine() {
		def g = new ValidationTagLib();
		return("${this.id},"
			+g.formatDate(date:this.journalDate)+","+subject0+","
			+g.message(code:"cjournal.journalType.${this.journalType}",default:"error")+","
            +"${amount},${projecti},${company},${subject0Balance},${inputMan},${memo?.replace(',','，')}\r\n")
			//+"${subject0},${subject1},${projecti},${amount},${inputMan},${company},${memo?.replace(',','，')},${subject0Balance},${subject1Balance}\r\n")
	}
}
