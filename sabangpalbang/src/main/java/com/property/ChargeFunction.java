package com.property;

public class ChargeFunction {
	public static String formatNumberWithUnit(long value) {
		if (value >= 100000000) {
			long 억 = value / 100000000;
			long 만 = (value % 100000000) / 10000;

			if (만 > 0) {
				return 억 + "억" + 만 + "만";
			} else {
				return 억 + "억";
			}
		} else if (value >= 10000) {
			return value / 10000 + "만";
		} else {
			return String.valueOf(value);
		}
	}
}
