class Store {
  static Map<String, Object> _storeValueMap = {};

  // 获取字符串数据
  static String stringValue(String key) {
    return _storeValueMap[key]?.toString() ?? "";
  }

  // 保存储存值
  static void setValue(String key, Object value) {
    _storeValueMap[key] = value;
  }
}
