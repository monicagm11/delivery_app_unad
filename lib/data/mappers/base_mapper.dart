abstract class BaseMapper<T, M> {
  T toEntity(M model);

  M toModel(T entity);
}