/**
 * 验证合法的Email
 * @param {} str
 */
function isEmail(str){
  var reg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
if(reg.test(str)){
 return true;
}else{
return false;
}
}
/**
 * 检查是否为 YYYY-MM-DD || YYYY/MM/DD 的日期格式
 * @param {} str
 * @return {Boolean}
 */
function isDate(str){
   var result=str.match(/^(\d{4})(-|\/)(\d{1,2})\2(\d{1,2})$/);
   if(result==null) return false;
   var d=new Date(result[1], result[3]-1, result[4]);
   return (d.getFullYear()==result[1] && d.getMonth()+1==result[3] && d.getDate()==result[4]);
}
/**
 * 判断输入是否是有效的长日期格式 - "YYYY-MM-DD HH:MM:SS" || "YYYY/MM/DD HH:MM:SS"
 * @param {} str
 * @return {Boolean}
 */
function isDatetime(str)
{
    var result=str.match(/^(\d{4})(-|\/)(\d{1,2})\2(\d{1,2}) (\d{1,2}):(\d{1,2}):(\d{1,2})$/);
    if(result==null) return false;
    var d= new Date(result[1], result[3]-1, result[4], result[5], result[6], result[7]);
    return (d.getFullYear()==result[1]&&(d.getMonth()+1)==result[3]&&d.getDate()==result[4]&&d.getHours()==result[5]&&d.getMinutes()==result[6]&&d.getSeconds()==result[7]);
}
/**
 * 判断输入是否是一个整数
 * @param {} str
 * @return {Boolean}
 */
function isint(str)
{
    //var result=str.match(/^(-|\+)?\d+$/);
    var result=str.match(/^\d+$/);
    if(result==null) return false;
    return true;
}
/**
 * 去除字符串的首尾的空格
 * @param {} str
 * @return {}
 */
function trim(str){
   return str.replace(/(^\s*)|(\s*$)/g, "");
}
/**
 * 返回字符串的实际长度, 一个汉字算2个长度
 * @param {} str
 * @return {}
 */
function strlen(str){
   return str.replace(/[^\x00-\xff]/g, "**").length;
}
/**
 * 匹配中国邮政编码
 * @param {} str
 * @return {Boolean}
 */
function isPostcode(str)
{
    var result=str.match(/^[1-9][0-9]{5}$/);
    if(result==null) return false;
    return true;
}
/**
 * 匹配身份证
 * @param {} str
 * @return {Boolean}
 */
function isIdcard(num){
    num = num.toUpperCase();
    //身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X。
    if (!(/(^\d{15}$)|(^\d{17}([0-9]|X)$)/.test(num)))
    {
       // alert('输入的身份证号长度不对，或者号码不符合规定！\n15位号码应全为数字，18位号码末位可以为数字或X。');
        return false;
    }
    //校验位按照ISO 7064:1983.MOD 11-2的规定生成，X可以认为是数字10。
    //下面分别分析出生日期和校验位
    var len, re;
    len = num.length;
    if (len == 15)
    {
        re = new RegExp(/^(\d{6})(\d{2})(\d{2})(\d{2})(\d{3})$/);
        var arrSplit = num.match(re);
 
        //检查生日日期是否正确
        var dtmBirth = new Date('19' + arrSplit[2] + '/' + arrSplit[3] + '/' + arrSplit[4]);
        var bGoodDay;
        bGoodDay = (dtmBirth.getYear() == Number(arrSplit[2])) && ((dtmBirth.getMonth() + 1) == Number(arrSplit[3])) && (dtmBirth.getDate() == Number(arrSplit[4]));
        if (!bGoodDay)
        {
            //alert('输入的身份证号里出生日期不对！');
            return false;
        }
        else
        {
                //将15位身份证转成18位
                //校验位按照ISO 7064:1983.MOD 11-2的规定生成，X可以认为是数字10。
                var arrInt = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2);
                var arrCh = new Array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2');
                var nTemp = 0, i;
                num = num.substr(0, 6) + '19' + num.substr(6, num.length - 6);
                for(i = 0; i < 17; i ++)
                {
                    nTemp += num.substr(i, 1) * arrInt[i];
                }
                num += arrCh[nTemp % 11];
                return true;
        }
    }
    if (len == 18)
    {
        re = new RegExp(/^(\d{6})(\d{4})(\d{2})(\d{2})(\d{3})([0-9]|X)$/);
        var arrSplit = num.match(re);
 
        //检查生日日期是否正确
        var dtmBirth = new Date(arrSplit[2] + "/" + arrSplit[3] + "/" + arrSplit[4]);
        var bGoodDay;
        bGoodDay = (dtmBirth.getFullYear() == Number(arrSplit[2])) && ((dtmBirth.getMonth() + 1) == Number(arrSplit[3])) && (dtmBirth.getDate() == Number(arrSplit[4]));
        if (!bGoodDay)
        {
            //alert('输入的身份证号里出生日期不对！');
            return false;
        }
    else
    {
        //检验18位身份证的校验码是否正确。
        //校验位按照ISO 7064:1983.MOD 11-2的规定生成，X可以认为是数字10。
        var valnum;
        var arrInt = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2);
        var arrCh = new Array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2');
        var nTemp = 0, i;
        for(i = 0; i < 17; i ++)
        {
            nTemp += num.substr(i, 1) * arrInt[i];
        }
        valnum = arrCh[nTemp % 11];
        if (valnum != num.substr(17, 1))
        {
            //alert('18位身份证的校验码不正确！应该为：' + valnum);
            return false;
        }
        return true;
    }
    }
    return false;
}
/**
 * 验证手机号码
 * @param {} str
 * @return {Boolean}
 */
function isTelephone(str){
	var reg = /^0?(13[0-9]|15[012356789]|18[0236789]|14[57])[0-9]{8}$/;
	if(reg.test(str)){
 		return true;
	}else{
		return false;
	}
}
/**
 * 验证电话号码
 * 1：区号是3为，其他是8位；2：区号是4位，其他是7位；3：区号是4位，其他是8位数字
 * @param {} str
 * @return {Boolean}
 */
function isTell(str){
	var reg= /^(\d{3}-)(\d{8})$|^(\d{4}-)(\d{7})$|^(\d{4}-)(\d{8})$/;
	if(reg.test(str)){
 		return true;
	}else{
		return false;
	}
} 
/**
 * 判断输入是否是一个由 0-9 / A-Z / a-z 组成的字符串
 * @param {} str
 * @return {Boolean}
 */
function isAlphanumber(str) {
        var result = str.match(/^[a-zA-Z0-9]+$/);
        if (result == null)
        {
        	return false;
        }else{
        	 return true;
        }
    }
/**
 * 判断输入是否是一个数字--(数字包含小数)
 * @param {} str
 * @return {}
 */
function isNumber(str)
{
    return !isNaN(str);
}
/**
 * 匹配腾讯QQ号
 * @param {} str
 * @return {Boolean}
 */
function isqq(str)
{
    var result=str.match(/[1-9][0-9]{4,}/);
    if(result==null) return false;
    return true;
}

//验证是否为空
/*function checkStr(str){
	var res = check(str);
	if(res==true){
		str=true;
	}else{
		str=false;
	}
}

function check(str){
	var val = document.getElementsByName(str+"span").value;
	var arr = new Array(str,"img");
	var img = arr.join("");
	var arr2 = new Array(str,"span");
	alert();
	var sp = arr2.join("");
	if(val){
		document.getElementById(img).src=right;
		document.getElementById(img).style.display='block';
		document.getElementById(sp).style.display='none';
		return true;
	}else{
		//document.getElementById(sp).src=wrong;
		document.getElementById(sp).style.display='block';
		document.getElementById(img).style.display='none';
		alert(str+'不能为空');
		document.getElementById(sp).value=str;
		return false;
	}
}
*/