package com.naver.jihyunboard.board.model;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class SwearWordFilter {

	private static String swearWordReg = "fuck|shit|개새끼";

	public static void main(String[] args) {
		String str = "야 이 개새끼";
		String result = SwearWordFilter.filterText(str);
		System.out.println(result);
	}

	public static String filterText(String text) {
		Pattern pattern = Pattern.compile(swearWordReg, Pattern.CASE_INSENSITIVE);
		Matcher match = pattern.matcher(text);
		StringBuffer sb = new StringBuffer();
		while (match.find()) {
			match.appendReplacement(sb, maskWord(match.group()));
		}
		match.appendTail(sb);
		return sb.toString();
	}

	public static String maskWord(String word) {
		StringBuffer buff = new StringBuffer();
		char[] ch = word.toCharArray();
		for (int i = 0; i < ch.length; i++) {
			if (i < 1) {
				buff.append(ch[i]);
			} else {
				buff.append("*");
			}
		}
		return buff.toString();
	}

}
