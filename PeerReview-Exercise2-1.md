# Peer-Review for Programming Exercise 2 #

## Description ##

For this assignment, you will be giving feedback on the completeness of assignment two: Obscura. To do so, we will give you a rubric to provide feedback. Please give positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to check the code and project files that the instructor gave out.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.   

## Due Date and Submission Information
See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer review. This review document should be placed into the base folder of the repo you are reviewing in the master branch. The file name should be the same as in the template: `CodeReview-Exercise2.md`. You must also include your name and email address in the `Peer-reviewer Information` section below.

If you are in a rare situation where two peer-reviewers are on a single repository, append your UC Davis user name before the extension of your review file. An example: `CodeReview-Exercise2-username.md`. Both reviewers should submit their reviews in the master branch.  

# Solution Assessment #

## Peer-reviewer Information

* *name:* [Elmer Leon] 
* *email:* [ealeon@ucdavis.edu]

### Description ###

For assessing the solution, you will be choosing ONE choice from: unsatisfactory, satisfactory, good, great, or perfect.

The break down of each of these labels for the solution assessment.

#### Perfect #### 
    Can't find any flaws with the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    Major flaw and some minor flaws.

#### Satisfactory ####
    Couple of major flaws. Heading towards solution, however did not fully realize solution.

#### Unsatisfactory ####
    Partial work, not converging to a solution. Pervasive Major flaws. Objective largely unmet.


___

## Solution Assessment ##

### Stage 1 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The position lock camera is correctly implemented. The student added a cross at the center of the screen when activated. The camera follows the vessel. 

___
### Stage 2 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Auto Scroll was perfectly implemented. The vessel is unable to leave the box and the box constantly moves in a direction. When activated the box is shown on screen. 

___
### Stage 3 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The position lock and lerping camera works as intended. The camera catches up to the vessel at a specifed speed. Even when in hyper speed the camera follows the vessel. When activated the cross appears. 

___
### Stage 4 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
lerp smoothing works perfectly as the camera now is ahead of the vessel. When testing in hyper speed the camera behaves properly and the cross as well. 

___
### Stage 5 ###

- [ ] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [x] Unsatisfactory

___
#### Justification ##### 
The camera is not implemented. The only feature added was drawing the box. The camera does not change when loaded and the vessel goes off screen. 
___
# Code Style #


### Description ###
Check the scripts to see if the student code adheres to the dotnet style guide.

If sections do not adhere to the style guide, please peramlink the line of code from Github and justify why the line of code has not followed the style guide.

It should look something like this:

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Please refer to the first code review template on how to do a permalink.


#### Style Guide Infractions ####
* Class name is not PascalCase [here](https://github.com/ensemble-ai/exercise-2-camera-control-RleonJarquin/blob/16a52b20992289fdd82fd7a477974370507f640b/Obscura/scripts/camera_controllers/position_lock.gd)

* Extra paranthesis [here](https://github.com/ensemble-ai/exercise-2-camera-control-RleonJarquin/blob/16a52b20992289fdd82fd7a477974370507f640b/Obscura/scripts/camera_controllers/position_lock_and_lerp.gd)



#### Style Guide Exemplars ####
* student did well with ordering variables. This followed all the files with correct defining as well [here](https://github.com/ensemble-ai/exercise-2-camera-control-RleonJarquin/blob/16a52b20992289fdd82fd7a477974370507f640b/Obscura/scripts/camera_controllers/position_lock_and_lerp.gd)

* here is an example of the student static typing their variables [here](https://github.com/ensemble-ai/exercise-2-camera-control-RleonJarquin/blob/16a52b20992289fdd82fd7a477974370507f640b/Obscura/scripts/camera_controllers/position_lock_and_lerp.gd)

* variable names are releveant and help make the code easier to understand [here](https://github.com/ensemble-ai/exercise-2-camera-control-RleonJarquin/blob/16a52b20992289fdd82fd7a477974370507f640b/Obscura/scripts/camera_controllers/four_way_speedup.gd)

* Student correctly ordered function based on the style guide [here](https://github.com/ensemble-ai/exercise-2-camera-control-RleonJarquin/blob/16a52b20992289fdd82fd7a477974370507f640b/Obscura/scripts/camera_controllers/position_lock_and_lerp.gd)



___
#### Put style guide infractures ####

___

# Best Practices #

### Description ###

If the student has followed best practices (Unity coding conventions from the StyleGuides document) then feel free to point at these code segments as examplars. 

If the student has breached the best practices and has done something that should be noted, please add the infraction.


This should be similar to the Code Style justification.

#### Best Practices Infractions ####
* Student left debugging print statments in the final code, which should be removed once done [here](https://github.com/ensemble-ai/exercise-2-camera-control-RleonJarquin/blob/16a52b20992289fdd82fd7a477974370507f640b/Obscura/scripts/camera_controllers/four_way_speedup.gd)

* in auto scroll the student could make the boundary checks into functions to make it easier to follow and makes the file more organized [here](https://github.com/ensemble-ai/exercise-2-camera-control-RleonJarquin/blob/16a52b20992289fdd82fd7a477974370507f640b/Obscura/scripts/camera_controllers/autoscroll.gd)

* student can incorporate lerp to allow for a smoother following [here](https://github.com/ensemble-ai/exercise-2-camera-control-RleonJarquin/blob/16a52b20992289fdd82fd7a477974370507f640b/Obscura/scripts/camera_controllers/position_lock_and_lerp.gd)

* when switching through cameras to allow for the camera to be placed where the vessel was last you can add position = target.position under !notcurrent. For example [here](https://github.com/ensemble-ai/exercise-2-camera-control-RleonJarquin/blob/16a52b20992289fdd82fd7a477974370507f640b/Obscura/scripts/camera_controllers/autoscroll.gd)



#### Best Practices Exemplars ####

* although the four way camera was not implmented the idea of using helper functions is good as breaks down the logic to make it more managable [here](https://github.com/ensemble-ai/exercise-2-camera-control-RleonJarquin/blob/16a52b20992289fdd82fd7a477974370507f640b/Obscura/scripts/camera_controllers/four_way_speedup.gd)

* The project was consistent with comments allowing for an easier time to understand what is happening. [here is an example in lock and lerp](https://github.com/ensemble-ai/exercise-2-camera-control-RleonJarquin/blob/16a52b20992289fdd82fd7a477974370507f640b/Obscura/scripts/camera_controllers/position_lock_and_lerp.gd)

* setting these values in _ready() is good practice as it stops possible future problems later on [here](https://github.com/ensemble-ai/exercise-2-camera-control-RleonJarquin/blob/16a52b20992289fdd82fd7a477974370507f640b/Obscura/scripts/camera_controllers/four_way_speedup.gd)

*