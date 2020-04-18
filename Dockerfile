FROM rabits/qt:5.14-android
COPY . .
CMD bash build.sh
