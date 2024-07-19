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
  List<DropdownMenuItem<String>> createDropdownMenuItems(
      List<String> modelList) {
    return modelList.map((String modelName) {
      return DropdownMenuItem<String>(
        alignment: AlignmentDirectional.center,
        value: modelName,
        child: Text(modelName),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('模型设置'),
        actions: <Widget>[
          // 修改标题按钮
          TextButton(
            onPressed: () {
              Provider.of<ModelConfigProvider>(context, listen: false)
                  .resetModelConfig();
            },
            child: const Text(
              "重置",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          )
        ],
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
    return Selector<ModelConfigProvider, ModelConfig>(
      selector: (context, model) => model.currentModelConfig,
      builder: (context, currentModelConfig, child) {
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
            child: DropdownButton<String>(
              value: currentModelConfig.model,
              alignment: AlignmentDirectional.center,
              items: Provider.of<ModelConfigProvider>(context, listen: false)
                  .modelList
                  .map((modelName) {
                return DropdownMenuItem<String>(
                  alignment: AlignmentDirectional.center,
                  value: modelName,
                  child: Text(modelName),
                );
              }).toList(),
              onChanged: (String? value) {
                if (value != null) {
                  Provider.of<ModelConfigProvider>(context, listen: false)
                      .updateModelConfig(model: value);
                }
              },
              hint: const Text('请选择模型'),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMaxTokensListTile(BuildContext context) {
    return Selector<ModelConfigProvider, ModelConfig>(
      selector: (context, model) => model.currentModelConfig,
      builder: (context, currentModelConfig, child) {
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
              controller: TextEditingController(
                text: currentModelConfig.maxTokens.toString(),
              ),
              scrollPadding: const EdgeInsets.all(0),
              maxLength: 5,
              decoration: const InputDecoration(
                counter:
                    SizedBox.shrink(), // Use counter instead of counterText
                hintText: '最大令牌数',
              ),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              onChanged: (String? value) {
                if (value != null) {
                  Provider.of<ModelConfigProvider>(context, listen: false)
                      .updateModelConfig(maxTokens: int.parse(value));
                }
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildRandomnessListTile(BuildContext context) {
    return Selector<ModelConfigProvider, ModelConfig>(
      selector: (context, model) => model.currentModelConfig,
      builder: (context, currentModelConfig, child) {
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
              value: currentModelConfig.temperature ?? 0,
              max: 1.0,
              min: 0.0,
              divisions: 10,
              label: currentModelConfig.temperature.toString(),
              onChanged: (double value) {
                Provider.of<ModelConfigProvider>(context, listen: false)
                    .updateModelConfig(
                  temperature: value,
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildNuclearSamplingListTile(BuildContext context) {
    return Selector<ModelConfigProvider, ModelConfig>(
      selector: (context, model) => model.currentModelConfig,
      builder: (context, currentModelConfig, child) {
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
              value: currentModelConfig.topP ?? 0,
              max: 1.0,
              min: 0.0,
              divisions: 10,
              label: currentModelConfig.topP.toString(),
              onChanged: (double value) {
                Provider.of<ModelConfigProvider>(context, listen: false)
                    .updateModelConfig(topP: value);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildHistoryMessageCountListTile(BuildContext context) {
    return Selector<ModelConfigProvider, ModelConfig>(
      selector: (context, model) => model.currentModelConfig,
      builder: (context, currentModelConfig, child) {
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
              value: currentModelConfig.historyMessages ?? 0,
              max: 10.0,
              min: 0.0,
              divisions: 10,
              label: currentModelConfig.historyMessages.toString(),
              onChanged: (double value) {
                Provider.of<ModelConfigProvider>(context, listen: false)
                    .updateModelConfig(historyMessages: value);
              },
            ),
          ),
        );
      },
    );
  }
}
