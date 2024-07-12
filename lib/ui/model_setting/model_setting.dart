import 'package:flutter/material.dart';
import 'package:one_chatgpt_flutter/common/log.dart';
import 'package:one_chatgpt_flutter/models/model_config.dart';
import 'package:one_chatgpt_flutter/state/model_config.dart';
import 'package:provider/provider.dart';

class ModelSetting extends StatefulWidget {
  const ModelSetting({super.key});

  @override
  State<ModelSetting> createState() => _ModelSettingState();
}

class _ModelSettingState extends State<ModelSetting> {
  String? _selectedModel;
  final List<String> _models = ['Option 1', 'Option 2', 'Option 3'];

  late ModelConfig _currentChatModel;

  double _currentSliderValue = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final config = Provider.of<ModelConfigProvider>(context);
    // Log.d(config.modelList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('模型设置'),
      ),
      body: Column(
        children: <Widget>[
          _buildModelSettingListTile(context),
          const SizedBox(height: 4),
          _buildMaxTokensListTile(context),
          const SizedBox(height: 4),
          _buildRandomnessListTile(context),
          const SizedBox(height: 4),
          _buildNuclearSamplingListTile(context),
          const SizedBox(height: 4),
          _buildHistoryMessageCountListTile(context),
        ],
      ),
    );
  }

  Widget _buildModelSettingListTile(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      title: const Text(
        '模型',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: const Text(
        "当前使用的模型",
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
      trailing: FittedBox(
        alignment: Alignment.center,
        child: DropdownButton<String>(
          value: _selectedModel,
          items: _models.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedModel = newValue;
            });
          },
          hint: const Text('请选择模型'),
        ),
      ),
    );
  }

  Widget _buildMaxTokensListTile(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      title: const Text(
        '最大令牌数',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: const Text(
        "单次交互所用的最大 Token 数",
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
      dense: true,
      trailing: SizedBox(
        width: 100,
        child: TextField(
          scrollPadding: EdgeInsets.all(0),
          maxLength: 5,
          decoration: const InputDecoration(
            counter: SizedBox.shrink(), // Use counter instead of counterText
          ),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          onChanged: (val) {
            print(val);
          },
        ),
      ),
    );
  }

  Widget _buildRandomnessListTile(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      title: const Text(
        '随机性',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: const Text(
        "值越大，回复越随机",
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
      dense: true,
      trailing: FittedBox(
        alignment: Alignment.centerRight,
        child: Slider(
          inactiveColor: Colors.grey[100],
          value: _currentSliderValue,
          max: 1.0,
          min: 0.0,
          divisions: 10,
          label: _currentSliderValue.toString(),
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
            });
          },
        ),
      ),
    );
  }

  Widget _buildNuclearSamplingListTile(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      title: const Text(
        '核采样',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: const Text(
        "与随机性类似，但不要和随机性一起更改",
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
      dense: true,
      trailing: FittedBox(
        alignment: Alignment.centerRight,
        child: Slider(
          inactiveColor: Colors.grey[100],
          value: _currentSliderValue,
          max: 1.0,
          min: 0.0,
          divisions: 10,
          label: _currentSliderValue.toString(),
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
            });
          },
        ),
      ),
    );
  }

  Widget _buildHistoryMessageCountListTile(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      title: const Text(
        '历史消息数',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: const Text(
        "每次请求携带的历史消息数",
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
      dense: true,
      trailing: FittedBox(
        alignment: Alignment.centerRight,
        child: Slider(
          inactiveColor: Colors.grey[100],
          value: _currentSliderValue,
          max: 1.0,
          min: 0.0,
          divisions: 10,
          label: _currentSliderValue.toString(),
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
            });
          },
        ),
      ),
    );
  }
}
