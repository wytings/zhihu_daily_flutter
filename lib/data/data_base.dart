class Data<T> {
  final int code;
  final String msg;
  final T entity;

  Data(this.code, this.msg, this.entity);

  @override
  String toString() {
    return 'Data{code: $code, msg: $msg, entity: $entity}';
  }
}
