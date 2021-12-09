package com.watson.dynamodb;

import java.util.Iterator;

import com.amazonaws.auth.InstanceProfileCredentialsProvider;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDB;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClientBuilder;
import com.amazonaws.services.dynamodbv2.document.DynamoDB;
import com.amazonaws.services.dynamodbv2.document.Item;
import com.amazonaws.services.dynamodbv2.document.ItemCollection;
import com.amazonaws.services.dynamodbv2.document.PutItemOutcome;
import com.amazonaws.services.dynamodbv2.document.ScanOutcome;
import com.amazonaws.services.dynamodbv2.document.Table;
import com.amazonaws.services.dynamodbv2.document.spec.ScanSpec;

public class DBHelper {

    public static void main(String[] args) {

    	ItemCollection<ScanOutcome> items = DBHelper.getResults();
    	Iterator<Item> iter = items.iterator();
    	StringBuilder output = new StringBuilder();
    	output.append("{\"results\":[");
    	while (iter.hasNext()) {
    	    Item item = iter.next();
    	    System.out.println(item.toString());
		    if(item.getString("Type").equalsIgnoreCase("Macro") && item.getString("Language").equalsIgnoreCase("English")) {
				output.append(item.toJSON());
				if(iter.hasNext()) {
					output.append(",");
				}
		    }
    	}
    	if(output.toString().endsWith(",")) {
    		output.substring(0, (output.length() - 1));
    	}
    	output.append("]}");
    	System.out.println(output.toString());
    	//addItem("Test123", "Button", "Testing 123", "English");
    }
    
    public static ItemCollection<ScanOutcome> getResults() {
        AmazonDynamoDB client = AmazonDynamoDBClientBuilder.standard()
//        		.withCredentials(new InstanceProfileCredentialsProvider(false))
        		.withRegion(Regions.US_EAST_1)
                .build();    

        DynamoDB dynamoDB = new DynamoDB(client);

        Table table = dynamoDB.getTable("polly");

        ScanSpec scanSpec = new ScanSpec();

        try {
            ItemCollection<ScanOutcome> items = table.scan(scanSpec);
            return items;

        }
        catch (Exception e) {
            System.err.println("Unable to scan the table:");
            System.err.println(e.getMessage());
        }
        return null;
    }
    
    public static void addItem(String name, String type, String phrase, String language) {
    	
        AmazonDynamoDB client = AmazonDynamoDBClientBuilder.standard()
//        		.withCredentials(new InstanceProfileCredentialsProvider(false))
        		.withRegion(Regions.US_EAST_1)
        		.build();

        DynamoDB dynamoDB = new DynamoDB(client);

        Table table = dynamoDB.getTable("polly");

        try {
            System.out.println("Adding a new item...");
            Item item = new Item().withPrimaryKey("Name", name, "Phrase", phrase).withString("Language", language).withString("Type", type);

            PutItemOutcome outcome = table
            	.putItem(item);

            System.out.println("PutItem succeeded:\n" + outcome.getPutItemResult().toString());

        }
        catch (Exception e) {
            System.err.println("Unable to add item: " + name + ": " + phrase);
            System.err.println(e.getMessage());
        }
    }
}