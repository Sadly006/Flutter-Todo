import 'package:flutter_todos/src/Utility/Constants/domains.dart';
import 'package:graphql/client.dart';

class GraphQLService {
  static final GraphQLService _singleton = GraphQLService._internal();

  factory GraphQLService() {
    return _singleton;
  }

  GraphQLService._internal();

  final GraphQLClient _client = GraphQLClient(
    link: HttpLink(apiBaseUrl),
    cache: GraphQLCache(),
  );

  Future<QueryResult> performQuery(String query,
      {Map<String, dynamic>? variables}) async {
    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: variables ?? {},
    );

    final QueryResult result = await _client.query(options);

    if (result.hasException) {
      throw result.exception!;
    }

    return result;
  }

  Future<QueryResult> performMutation(String mutation,
      {Map<String, dynamic>? variables}) async {
    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: variables ?? {},
    );

    final QueryResult result = await _client.mutate(options);

    if (result.hasException) {
      throw result.exception!;
    }

    return result;
  }
}
