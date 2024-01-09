This is a WIP and will eventually be ported to C++ to be used in ROS. I am using Java as the starting language since I am more familiar with it than C++ and I can worry about learning the path planning aspect instead of trying to learn C++ at the same time.

The ultimate goal of this program is to determine the shortest 'route' to a goal position, and then determine the best* path along this route using the elastic band technique.

*The best path is not always the shortest path. It must be traversable by a robot of radius r, and be a certain distance away from obstacles.

In this README, I use the words 'route' and 'path', but not interchangeably.

A 'route' is predefined, ordered locations on the map.
e.g. go down hallway A, then through door D, around a pole on the left, etc... The rough travel distance of these steps will be calculated based on the jagged path that the RRT finds. It may not always be the shortest path, but should get pretty close. This is necessary since the elastic band must be initiated along a path that does not have collisions.

The 'path' is the physical curve that a robot would traverse along. The final path once the elastic band has converged to a solution, will not be the absolute shortest path possible. This is because the elastic band technique employs tension and repulsion forces. This causes the path to be incrementally pulled tighter, removing slack, while also getting repelled away from obstacles. The elastic band technique will attempt to push the robot towards the center of the room. This repulsion force can be adjusted so that the path can be pushed farther from obstacles if desired. A minimum radius can also be set to confirm that a path is traversable by a physical robot. This radius would be checked across all nodes in the elastic band. This would not be the shortest path, but it will be the safest path, and the most efficient with the least amount of sharp turns. Also, obstacles that people leave in a room are typically left along walls instead of in the middle of walkway. This reduces potential collisions and issues if someone decides to move a trashcan for example. 

Another issue that can be avoided by traversing where obstacles are less likely to be, is where a new obstacle is detected that interferes with the elastic band path. This will cause problems as the repulsion forces on the band would not have a clear direction. The elastic band would get stuck in the center of the obstacle. If this happens, the 'bubbles' in the elastic band would have shrunk smaller than the robot, invalidating the route, and causing a new one to be calculated, and a new elastic band path to be generated.

TODO: Figure out how to determine alternate routes if the route that the RRT algorithm finds in not traversable by a robot. This could happen if a route is found through a very tiny opening between two obstacles.


Use Processing 4 to run the program.

Use right mouse button and drag to draw obstacles.

Use left click to create a start point, click again to make an endpoint, left click again to delete start and endpoints.

Use spacebar to clear all obstacles from the grid.

Use 'g' to generate the RRT. 'c' to clear.

Use 'l' to load obstacles from a file. Use 's' to save obstacles.

UPDATE 1/9/2024: Obstacles and RRT working

![2024-01-09_094311](https://github.com/bears0/ElasticBandPathPlanner/assets/44094319/9ec544fe-67f3-47d6-bc54-35dd5474446a)

![2024-01-09_094331](https://github.com/bears0/ElasticBandPathPlanner/assets/44094319/2a589085-9d29-43fa-8a6d-b02656f019f2)
