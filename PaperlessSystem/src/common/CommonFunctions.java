package common;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;

import db.DbConnection;

/***
 *
 * @author H.Hayashi
 *
 */
public final class CommonFunctions {
	/**  */
	private CommonFunctions() {}

	/**
	 *
	 * @author H.Hayashi
	 *
	 */
	 public final class IniFileReader {

		/** HashMap for the Sections */
		private HashMap<String, HashMap<String, String>> mSections;

		/**
		 * Loads the Ini-File
		 *
		 * @param iniFile File to load
		 * @throws IOException
		 */
		public IniFileReader(File iniFile) throws IOException{ readIni(new BufferedInputStream(new FileInputStream(iniFile))); }

		/**
		 * Loads the Ini from a InputStream
		 *
		 * @param stream Stream with Ini-File
		 * @throws IOException
		 */
		public IniFileReader(InputStream stream) throws IOException { readIni(stream); }

		/**
		 * Reads the Ini from a Stream
		 *
		 * @param stream Stream with Ini-File
		 * @throws IOException
		 */
		private void readIni(InputStream stream) throws IOException {

			BufferedReader reader = new BufferedReader(new InputStreamReader(stream));
			String str;
			mSections = new HashMap<String, HashMap<String, String>>();
			HashMap<String, String> map = new HashMap<String, String>();
			Pattern section = Pattern.compile("^\\[.*\\]\\w*");
			Pattern keyvalue = Pattern.compile("^.*=.*\\w*");
			while ((str = reader.readLine()) != null) {
				if (section.matcher(str).matches()) {
					str = str.trim();
					str = str.substring(1, str.length()-1);
					map = new HashMap<String, String>();
					mSections.put(str, map);
				} else if (keyvalue.matcher(str).matches()){
					String key = StringUtils.substringBefore(str,"=");
					String value = StringUtils.substringAfter(str,"=");
					map.put(key, value);
				}
			}

		}

		/**
		 * Get a specific "Section" of the Ini-File. Each Key=Value is stored
		 * in the HashMap as Key = Value
		 *
		 * @param section Section to return
		 * @return Specific Section as HashMap
		 */
		public HashMap<String, String> getSection(String section) { return mSections.get(section); }

		/**
		 * Gets all available Sections in the loaded Ini-File
		 * @return
		 */
		public String[] getAllSections() { ArrayList<String> list = new ArrayList<String>(mSections.keySet()); return list.toArray(new String[list.size()]); }
	}

	 /**
	  *
	  * @param section
	  * @throws IOException
	  */
	public void getIniFileData(String section) throws IOException {
		String path = new File(".").getAbsoluteFile().getParent() + "\\setting.ini";
		IniFileReader reader = new IniFileReader(new File(path));

		@SuppressWarnings("unused")
		HashMap<String, String> params = reader.getSection(section);


	}

	/**
	 * 数値判定を行う。
	 * @param num
	 * @return
	 */
	public static boolean isNumber(Object num) {
		try {
			String regex = "\\A[-]?[0-9]+\\z";
			Pattern p = Pattern.compile(regex);
			Matcher m = p.matcher((String) num);
			return m.find();
		} catch (NumberFormatException e) {
			return false;
		}
	}

	/**
	 * Null判定を行う。NullであればTrueを返す。
	 * @param Null判定を行いたい値
	 * @return Nullか否
	 */
	public static boolean isNull(Object obj) { return (obj==null); }

	/**
	 *
	 * @param PropertyName
	 * @return
	 * @throws IOException
	 */
	public static Properties getProperties(String PropertyName) throws IOException {
		Properties properties = new Properties();
		//
		InputStream inStream = DbConnection.class.getClassLoader().getResourceAsStream(PropertyName);
		properties.load(inStream);
		inStream.close();
		return properties;
	}

	/**
	 *
	 * @param host
	 * @return
	 * @throws UnknownHostException
	 */
	public static String getIPAddress(String host) throws UnknownHostException {

		InetAddress ia = InetAddress.getByName (host);
		byte [] bs = ia .getAddress () ;

		StringBuilder ip = new StringBuilder();
		for (int i = 0, count = bs.length; i < count; i++) {
			ip.append(bs[i] & 0xFF);
			if (i != count - 1) ip.append(".");
		}

		return ip.toString();
	}

	/**
	 *
	 * @param num
	 * @return
	 */
	public static Integer intCast(Object num) {
		try {
			return Integer.parseInt(num.toString());
		} catch (Exception e) {
			return 0;
		}
	}

	/**
	 * 文字列型配列の中身を文字列に変換する。
	 * （java8 の String#join）
	 * @param ary
	 * @return
	 */
	public static String join(String[] ary) {
		try {
			StringBuilder builder = new StringBuilder();
			for(String str : ary) {
				builder.append(str).append(",");
			}
			return builder.deleteCharAt(builder.lastIndexOf(",")).toString();
		} catch (NullPointerException e) {
			return new String();
		}
	}
}