
for i in "find . -name \"*.h\"";
do path=$(dirname $i);
	 echo "i = "  $i			 
	 echo "dirname = "  $(dirname $i)
	 echo "path = "  $path
	 # mkdir -p absl-bak/include/$path;
	 # cp $i absl-bak/include/$path;
done
