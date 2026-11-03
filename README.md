# RAS 545 Lab 1 — Dobot Magician Lite Forward Kinematics

In this ASU Robotics 1 team lab, we used DobotStudio to operate a Dobot Magician Lite in joint and end-effector control modes. We then derived a forward-kinematics model and used MATLAB to compute the tool pose for comparison with DobotStudio's readout.

## How the model works

[`Lab1RAS545.m`](Lab1RAS545.m) starts with a fixed set of joint angles and link dimensions. It computes rotations in degrees and applies fixed frame rotations to account for how neighboring joint frames are oriented. The model sets `theta4 = -theta3` to represent the linkage that counteracts the preceding joint's rotation and keeps the tool level.

The script combines each relative rotation and translation into a 4-by-4 homogeneous transform. It multiplies the transforms in chain order to express the tool pose in the base frame:

```text
H05 = H01 * H12 * H23 * H34 * H45
```

The first three entries in the last column of `H05` give the end-effector position (`Px`, `Py`, and `Pz`). The upper-left 3-by-3 block gives the orientation. The script converts that rotation to ZYX Euler angles with `rotm2eul` and displays the angles in degrees.

## Lab results

Our team report records agreement with DobotStudio within the lab's stated tolerances of ±10 mm for position and ±5° for orientation. The MATLAB script computes one example pose from its embedded joint angles. Comparing it against hardware requires a DobotStudio reading for that same joint configuration.

## Run the MATLAB example

Open MATLAB in the repository folder and run:

```matlab
Lab1RAS545
```

The script uses `rotm2eul` and prints the intermediate matrices, the final base-to-tool transform, the position components, and the Euler angles. The calculation runs offline. Hardware control for the lab was performed separately in DobotStudio.
