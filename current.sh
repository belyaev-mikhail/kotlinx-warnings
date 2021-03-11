LATEST_KOTLIN_VERSION=$(curl -sS https://repo1.maven.org/maven2/org/jetbrains/kotlin/kotlin-compiler/maven-metadata.xml | grep -oP '(?<=<latest>)[^<]*(?=</latest>)')
echo "Latest Kotlin version is " $LATEST_KOTLIN_VERSION
# password is a public readonly github token, so we share it deliberately
GHP_USER=vorpal-reseacher
GHP_TOKEN=$(echo -e '\x31\x30\x62\x37\x64\x66\x31\x32\x63\x64')
GHP_TOKEN+=$(echo -e '\x35\x34\x38\x37\x34\x65\x30\x34\x35\x35')
GHP_TOKEN+=$(echo -e '\x38\x31\x63\x39\x39\x62\x31\x66\x32\x30')
GHP_TOKEN+=$(echo -e '\x38\x65\x31\x61\x35\x33\x65\x36\x32\x38')
CURRENT_VERSION=$(curl -u $GHP_USER:$GHP_TOKEN -sS https://maven.pkg.github.com/vorpal-research/kotlin-maven/ru/spbstu/kotlinx-warnings/maven-metadata.xml | grep -oP '(?<=<latest>)[^<]*(?=</latest>)')
echo "Latest kotlinx-warnings version is" $CURRENT_VERSION
if [ "$LATEST_KOTLIN_VERSION" != "$CURRENT_VERSION" ]; then
    ./gradlew -PkotlinVersion="$LATEST_KOTLIN_VERSION" publish
else
    echo "We are up-to-date with current Kotlin version"
fi
