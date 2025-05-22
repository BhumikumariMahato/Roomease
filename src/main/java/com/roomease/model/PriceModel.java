package com.roomease.model;

public class PriceModel{
	private int price_ID;
	private int price_monthly;
	private int price_deposit_amount;
	
	public PriceModel(int price_ID, int price_monthly, int price_deposit_amount) {
		this.price_ID = price_ID;
		this.price_monthly = price_monthly;
		this.price_deposit_amount = price_deposit_amount;
	}
	public int getPrice_ID() {
		return price_ID;
	}
	public void setPrice_ID(int price_ID) {
		this.price_ID = price_ID;
	}
	public int getPrice_monthly() {
		return price_monthly;
	}
	public void setPrice_monthly(int price_monthly) {
		this.price_monthly = price_monthly;
	}
	public int getPrice_deposit_amount() {
		return price_deposit_amount;
	}
	public void setPrice_deposit_amount(int price_deposit_amount) {
		this.price_deposit_amount = price_deposit_amount;
	}
	
	
}