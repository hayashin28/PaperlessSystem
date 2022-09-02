package logger;
public interface logger {
    //ここにファイル名とファイルパスの情報を書きます。
    static final String ROOT_DIR = System.getProperty("user.dir");
    static final String LOGGING_PROPERTIES = "logging.properties";
}
