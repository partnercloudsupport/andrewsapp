import 'package:scoped_model/scoped_model.dart';
import './theme_state_model.dart';

// class MainStateModel extends Model with ThemeStateModel {
class MainStateModel extends Model {
  static MainStateModel of(context) =>
      ScopedModel.of<MainStateModel>(context, rebuildOnChange: true);
}
