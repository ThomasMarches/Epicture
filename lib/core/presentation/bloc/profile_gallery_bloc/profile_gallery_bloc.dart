import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_gallery_event.dart';
part 'profile_gallery_state.dart';

class ProfileGalleryBloc
    extends Bloc<ProfileGalleryBlocEvent, ProfileGalleryBlocState> {
  ProfileGalleryBloc() : super(ProfileGalleryBlocInitial()) {
    on<ProfileGalleryBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
