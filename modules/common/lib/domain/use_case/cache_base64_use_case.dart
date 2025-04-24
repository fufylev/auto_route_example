import 'dart:convert';
import 'dart:io';

import 'package:common/domain/entity/file_entity.dart';
import 'package:common/usecase/usecase.dart';
import 'package:path_provider/path_provider.dart';

class CacheBase64UseCase extends UseCase<FileEntity, CacheBase64UseCaseParams> {
  @override
  Future<UseCaseResult<FileEntity>> call(CacheBase64UseCaseParams params) async {
    try {
      final binaryData = base64.decode(params.encoded);

      final tempDir = await getTemporaryDirectory();

      final dir = Directory('${tempDir.path}/cached/');
      final isExist = await dir.exists();
      if (!isExist) {
        await dir.create(recursive: true);
      }

      final filePath = '${dir.path}/${params.name}';
      await File(filePath).writeAsBytes(binaryData, flush: true);

      return UseCaseResult.successful(FileEntity(name: params.name, path: filePath));
    } catch (e, trace) {
      return useCaseResultFromException(e, trace: trace);
    }
  }
}

class CacheBase64UseCaseParams {
  final String encoded;
  final String name;

  CacheBase64UseCaseParams({
    required this.encoded,
    required this.name,
  });
}
