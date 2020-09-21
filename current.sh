LATEST_KOTLIN_VERSION=$(curl -sS https://api.github.com/repos/jetbrains/kotlin/releases/latest | grep -o '"name"\s*\:\s*"Kotlin\s*\(.*\)"' | grep -o "[0-9.]*")
echo "Latest Kotlin version is " $LATEST_KOTLIN_VERSION
CURRENT_VERSION=$(curl -sS https://dl.bintray.com/vorpal-research/kotlin-maven/ru/spbstu/kotlinx-warnings/maven-metadata.xml | grep -o '<latest>[^<]*</latest>' | grep -o "[0-9.]*")
echo "Latest kotlinx-warnings version is " $CURRENT_VERSION
if [ "$LATEST_KOTLIN_VERSION" != "$CURRENT_VERSION" ]; then
    ./gradlew -PkotlinVersion=LATEST_KOTLIN_VERSION build bintrayUpload
else
    echo "We are up-to-date with current Kotlin version"
fi
