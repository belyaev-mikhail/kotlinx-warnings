LATEST_KOTLIN_VERSION=$(curl -sS https://repo1.maven.org/maven2/org/jetbrains/kotlin/kotlin-compiler/maven-metadata.xml | grep -o '<latest>[^<]*</latest>' | grep -o "[0-9.]*")
echo "Latest Kotlin version is " $LATEST_KOTLIN_VERSION
CURRENT_VERSION=$(curl -sS https://dl.bintray.com/vorpal-research/kotlin-maven/ru/spbstu/kotlinx-warnings/maven-metadata.xml | grep -o '<latest>[^<]*</latest>' | grep -o "[0-9.]*")
echo "Latest kotlinx-warnings version is " $CURRENT_VERSION
if [ "$LATEST_KOTLIN_VERSION" != "$CURRENT_VERSION" ]; then
    ./gradlew -PkotlinVersion=LATEST_KOTLIN_VERSION publish
else
    echo "We are up-to-date with current Kotlin version"
fi
