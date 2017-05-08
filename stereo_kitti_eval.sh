#!/bin/sh
echo "Evaluating stereo performance based on KITTI odometry dataset..."

if [ $2 -lt 3 ]; then
	YAML_STR=Examples/Stereo/KITTI00-02.yaml
elif [ $2 -eq 3 ]; then
	YAML_STR=Examples/Stereo/KITTI03.yaml
else
	YAML_STR=Examples/Stereo/KITTI04-12.yaml
fi

printf -v SEQ "%s/%02d" $1 $2

env CPUPROFILE_FREQUENCY=200 ./Examples/Stereo/stereo_kitti Vocabulary/ORBvoc.txt $YAML_STR $SEQ

pprof --pdf --nodecount=100 ./Examples/Stereo/stereo_kitti ORB_SLAM2_TOTAL.prof >> ORB_SLAM2_TOTAL_$2.pdf 

wait

echo "Start to do KITTI benchmark analysis..."

./evaluate_odometry ./CameraTrajectory.txt $2

echo "Evaluate successed!"
