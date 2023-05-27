package com.posco.hanmadang.util;

import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.OutputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.concurrent.TimeUnit;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.StringUtils;

public class Util {
	public  static String getImageUrl(String path){
      return "/upload/" + path;
    } 
	
	/**
     * 페이징에 사용할 url format
     *
     * @param baseUrl 
     * @param queryString 
     * @param pageNumber 
     * @return String
     */
	public static String getPagingBaseUrl(String baseUrl, String queryString, int pageNumber) {
		if (StringUtils.isEmpty(queryString)) {
            queryString = "pageNumber=1";
        } else if (queryString.indexOf("pageNumber") < 0) {
            queryString = queryString + "&pageNumber=1";
        }
        queryString = queryString.replace("pageNumber=" + pageNumber, "pageNumber=%pageNumber%");
        
        return baseUrl + "?" + queryString + "#list";
	}
	
	public static String getYoil(String yyyyMMdd) {

		Calendar cal= Calendar.getInstance ();
	
	    cal.set(Calendar.YEAR, Integer.parseInt(yyyyMMdd.substring(0, 4)));
	    cal.set(Calendar.MONTH, Integer.parseInt(yyyyMMdd.substring(4, 6)) - 1);
	    cal.set(Calendar.DAY_OF_MONTH, Integer.parseInt(yyyyMMdd.substring(6, 8)));
	
	    int yoil = cal.get(Calendar.DAY_OF_WEEK);
	    yoil -= 1;
	    if(yoil == 0)
	    	yoil = 7;
	    
	    return String.valueOf(yoil);
	}
	
	public static String readContentFrom(String textFileName) throws IOException {
        BufferedReader bufferedTextFileReader = new BufferedReader(new FileReader(textFileName));
        StringBuilder contentReceiver = new StringBuilder();
        char[] buf = new char[1024];
        
        while (bufferedTextFileReader.read(buf) > 0) {
            contentReceiver.append(buf);
            buf = new char[1024];
        } 
 
        bufferedTextFileReader.close();
        return contentReceiver.toString();
    } 
	
	public  static long getDDaysFromCurrent(String endDate){
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyyMMdd");

		try {
			
		    Date to = myFormat.parse(endDate);
		    Date from = myFormat.parse(myFormat.format(Calendar.getInstance().getTime()));
		    long diff = from.getTime() - to.getTime();
		    System.out.println ("Days: " + TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS));
		    
		    return TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS);
		} catch (ParseException e) {
		    System.out.println(e.getMessage());
		}
		
		return 0;
    }
	
	public  static long getDHoursFromCurrent(String endDate){
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyyMMdd HH:mm:ss");
		try {
		    Date to = myFormat.parse(endDate);
		    Date from = myFormat.parse(myFormat.format(Calendar.getInstance().getTime()));
		    long diff = from.getTime() - to.getTime();
		    System.out.println ("hours: " + diff / (60 * 60 * 1000));
		    
		    return diff / (60 * 60 * 1000);
		} catch (ParseException e) {
		    System.out.println(e.getMessage());
		}
		
		return 0;
    }
	
	public  static boolean isBetween(String fromDate, String toDate){
		SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
		    Date to = myFormat.parse(toDate);
		    Date from = myFormat.parse(fromDate);
		    
		    Date cur = myFormat.parse(myFormat.format(Calendar.getInstance().getTime()));
		    
		   if(cur.after(from) && cur.before(to))
			   return true;
		    
		    if(cur.compareTo(from) == 0 || cur.compareTo(to) == 0 )
		    	return true;
		    
		    return false;
//		    return cur.after(from) && cur.before(to);
		    
		} catch (ParseException e) {
		    System.out.println(e.getMessage());
		}
		
		return false;
    }
	
	public static String getExtension(String fileStr){
	  return fileStr.substring(fileStr.lastIndexOf(".")+1,fileStr.length());
	 }
	
	public static String getDate( int year, int month, int week, int dayOfWeek )
	{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
	   Calendar calendar = Calendar.getInstance();
	   calendar.set(Calendar.YEAR, year );
	   calendar.set(Calendar.MONTH, month - 1);
	   calendar.set(Calendar.WEEK_OF_MONTH, week );
	   calendar.set(Calendar.DAY_OF_WEEK, dayOfWeek );

	   return formatter.format(calendar.getTime());
	}
	
	public static void writeImage(HttpServletResponse response, BufferedImage bi) {
        
        response.setHeader("Cache-Control", "private,no-cache,no-store");
        response.setContentType("image/png");
         
        try {
            writeImage(response.getOutputStream(), bi);
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
         
    }
 
    public static void writeImage(OutputStream os, BufferedImage bi) {
         
        try {
            ImageIO.write(bi, "png", os);
            os.close();
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
         
    }   
}
