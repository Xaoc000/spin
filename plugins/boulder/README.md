# BoulderAI Service Plugin

## Description

This is a service deployment of BoulderAI Camera demo. This will deploy two microservices to a single agent to work in concert together.

The first will run YOLO on the boulder camera's RSTP stream, and then take the data generated from this, and pass it as 
a set of JSON to the other microservice.

The second microservice will display the data from the first, by parsing it in nodeJS, and then dispalying it in a simple web app

Together these two provide the service of running accelerated image recognition algorithms on a camera livestream, and 
processing the data for easy display and consumption.

## Deployment

This will first check if a valid catalog item already matches each microservice. If not, it will add them and parse their catalog
IDs. If there is, it will grab their catalog IDs, and deploy the microservices.

If microservices are already deployed, this will default to simply updating the image after one has been run and built,
that way the camera can get remote improvements, without needing someone to connect directly to hardware.

## Test

Test will curl down the display page of the camera, and ensure that data is being sent up, and parsed. We are looking for an HTML 200
response, above all else, as we don't care about the validity of the data the camera is generating at this point, only that it is generating data, 
and that the web service is receiving it.