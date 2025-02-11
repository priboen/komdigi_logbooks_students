import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:komdigi_logbooks_students/datasources/internship_remote_datasources.dart';

part 'delete_internship_event.dart';
part 'delete_internship_state.dart';
part 'delete_internship_bloc.freezed.dart';

class DeleteInternshipBloc extends Bloc<DeleteInternshipEvent, DeleteInternshipState> {
  final InternshipRemoteDatasources datasources;
  DeleteInternshipBloc(this.datasources) : super(_Initial()) {
    on<_DeleteInternship>((event, emit) async{
      emit(_Loading());
      final result = await datasources.deleteInternship(event.id);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success()),
      );
    });
  }
}
