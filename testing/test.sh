#/bin/bash

# Hvordan bruke:
# ./test.sh [deres-egen-interpret.asp] [vei/til/referanseinterpret.asp] [log-flagg] [testflagg]
# Eksempel: ./test.sh asp.jar Reference/asp.jar -logP -testparser

# NB! Om scriptet ikke vil kjøre: chmod +x test.sh
# NB! Fungerer kun på UNIX-systemer (Mac/Linux)

# Fjerner og kompilerer interpreten på nytt
#rm asp.jar
#ant

# Obligatoriske Programmer
echo "Kjører referanseinterpret"
for file in Reference/*.asp; do
    echo $file
    java -jar $2 $3 $4 $file
	
    echo "-----"
done
echo "====================================================="

echo "Kjører obligatoriske programmer..."
for file in Obligatorisk/*.asp; do
    echo $file
    java -jar $1 $3 $4 $file
    echo "-----"
done
echo "====================================================="

# Andre Testprogrammer
echo "Kjører testprogrammer..."
for file in Test/*.asp; do
    echo $file
    java -jar $1 $3 $4 $file
    echo "-----"
done
echo "====================================================="

# Feil
echo "Tester Feil..."
for file in Feil/*.asp; do
    echo $file
    java -jar $1 $3 $4 $file
    echo "-----"
done
echo "====================================================="

# Diff
echo "Diff på obligatoriske programmer..."
for file in Obligatorisk/*.log; do
    base=$(basename $file)
    echo $base
    diff Reference/$base Obligatorisk/$base
    echo "------"
done
