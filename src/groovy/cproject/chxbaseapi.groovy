package cproject
import java.text.SimpleDateFormat
import java.util.Date;
import java.util.Map;

class chxbaseapi {
	/****
	 * 获取输入的日期。
	 * 由于从VIEW页面获取的参数类型比较多，因此在此统一进行处理，恢复成DATE型
	 * 有时GET方式下，获取的日期是一个字符型，相当于DATE.toString()还是美国地区的
	 * 有时GET方式下，获取的日期会自动分成YEAR\MONTH\DAY三个参数
	 *
	 * @author 蔡贺曦
	 * @param params 从VIEW页面传入的参数
	 * @param paramsname 变量的名称
	 * @return 日期或null
	 * @create 2013.4.10
	 */
	static Date paramsDate(Map params,String paramsname,Date defaultDate = null){
	  if (!params.get(paramsname)) return defaultDate ;
	  if (params.get(paramsname) instanceof Date) return params.get(paramsname);
	  if (params."${paramsname}_year")
		return (new Date(params.int("${paramsname}_year") - 1900, params.int("${paramsname}_month") - 1, params.int("${paramsname}_day")))
	  if (params."${paramsname}" instanceof String) {
		try {
		  SimpleDateFormat df = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy",java.util.Locale.US)
		  return df.parse(params."${paramsname}")
		}
		catch (Exception e){
		   return defaultDate
		}
	  }
	  return defaultDate
	}
  
}
