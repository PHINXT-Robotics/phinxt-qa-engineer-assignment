PHINXT QA Engineer assignment
==========================================

## Introduction

You will test a service that navigates an imaginary robotic hoover (much like a [Roomba](https://en.wikipedia.org/wiki/Roomba)) 
through an equally imaginary room based on:


* room dimensions as [X and Y coordinates](https://en.wikipedia.org/wiki/Cartesian_coordinate_system), identifying the top right corner of the room rectangle. This room is divided up in a grid based on these dimensions; a room that has dimensions X: 5 and Y: 5 has 5 columns and 5 rows, so 25 possible hoover positions. The bottom left corner is the point of origin for our coordinate system, so as the room contains all coordinates its bottom left corner is defined by X: 0 and Y: 0 and the top-right corner of a 5 by 5 room is defined by X: 4 and Y: 4.
* locations of patches of dirt, also defined by X and Y coordinates identifying the bottom left corner of those grid positions.
* an initial hoover position (X and Y coordinates like patches of dirt)
* driving instructions (as [cardinal directions](https://en.wikipedia.org/wiki/Cardinal_direction) where e.g. N and E mean "go north" and "go east" respectively) 

The room will be rectangular, has no obstacles (except the room walls), no doors and all locations in the room will be clean (hoovering has no effect) except for the locations of the patches of dirt presented in the program input.

Placing the hoover on a patch of dirt ("hoovering") removes the patch of dirt so that the patch is then clean for the remainder of the program run. The hoover is always on - there is no need to enable it.

Driving into a wall has no effect (the robot skids in place).

## Goal

The service takes the room dimensions, the locations of the dirt patches, the hoover location and the driving instructions as input and then produces an output like the following:

* The final hoover position (X, Y)
* The number of patches of dirt the robot cleaned up

Your goal is to verify whether the provided implementation behaves according to specification.

## Service specification

### Input

Program input will be received in a json payload with the format described here.

Example:

```javascript
{
  "roomSize" : [5, 5],
  "coords" : [1, 2],
  "patches" : [
    [1, 0],
    [2, 2],
    [2, 3]
  ],
  "instructions" : "NNESEESWNWW"
}
```

Where `roomSize` represents the size of the room, `coords` represents the initial position of the hoover and `patches` are the coordinates of the dirt patches.
Finally, `instructions` are the the commands that the hoover should execute.
In each of the arrays inside the input, the first element represents the coordinates on the X axis and the second element represents the coordinates on the Y axis.

## Output

Service output is returned as a json payload.

Example (matching the input above):

```javascript
{
  "coords" : [1, 3],
  "patches" : 1
}
```
Where `coords` are the final coordinates (X: 1, Y: 3) of the hoover and `patches` is the number of cleaned patches.

## Deliverable

Send us:

* Clear instructions on how to read/interpret the test suite
* The test suite as a table including the executed test cases (it can be a spreadsheet or a word/pdf/markdown document)
* A detailed report of the bugs that were detected (if any)
* Optionally, try to build an automated test suite reproducing the bugs that you have detected.

## Evaluation

The point of the exercise is for us to see: 

- How you structure your tests
- How you explain the approach you took and the assumptions you made
- How you deal with uncertainty and contribute to requirements specification
- How you approach API testing 
- How experienced you are at spotting nasty bugs!  

We will especially consider:

* Quality of instructions
* Quality of the report
* Percentage of the detected bugs

## How to execute the service to test
### Requirements
- Docker v.19+ (you can install Docker by following these instruction https://docs.docker.com/engine/install/)

### Building the service
From the root of this repository, run the following in a terminal:
```shell
docker build -t sdet-assignment .
```
### Running the service
From the terminal, run the following:
```shell
docker run --rm -p 8080:8080 sdet-assignment
```
### Hitting the endpoint
You can test whether the service is running correctly by executing the following command:
```shell 
curl -H 'Content-Type: application/json' -X POST -d @example-payload.json http://localhost:8080/v1/cleaning-sessions
```

If you don't have `curl` installed, you can use a tool like [Postman](https://www.postman.com/downloads/)
Then set the request as follows:
- Method: `POST`
- URL: `http://localhost:8080/v1/cleaning-sessions`
- Headers: `Content-Type: application/json`
- Body as follows
```json
{
  "roomSize" : [5, 5],
  "coords" : [1, 2],
  "patches" : [
    [1, 0],
    [2, 2],
    [2, 3]
  ],
  "instructions" : "NNESEESWNWW"
}
```


