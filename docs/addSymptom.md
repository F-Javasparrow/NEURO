# 添加症状

## 1.编辑 [Neuro_Medical_Symptoms.hpp](https://github.com/F-Javasparrow/Neurotrauma/tree/master/addons/medical_engine/Neuro_Medical_Symptoms.hpp) 并在对应的分区内添加新症状, 格式如下:

```.hpp

class Example: SymptomBase {
	displayName = "示例症状";                                                  // 症状名
	displayDesc = "示例症状描述";                                              // 症状描述
	displayPic = "\x\neuro\addons\medical_gui\ui\symptomIcon\Bleeding.paa";   // 症状图标
	visableLevel = 0;                                                         // 症状可见的最低医疗能力
	visableValue[] = {0.1,2};                                                 // 症状可见的严重程度的上下限 (优先级高于visableLevel)
	maxSeverity = 2;                                                          // 症状的最大严重程度 (此为200%)
	class details {
		type = "Symptom";                         // 症状的类型
		                                          // 以下皆为可选项
		changeHR[] = {0,0};                       // 对心率的持续性直接影响         [下限,上限]
		changeRR[] = {0,0, 0,0};                  // 对血压的持续性直接影响         [低压下限,低压上限, 高压下限,高压上限]
		changeSPo2[] = {0,0};                     // 对血氧的持续性直接影响         [下限,上限]
		tragetHR[] = {0,0};                       // 对目标心率的单次影响           [下限,上限]
		tragetRR[] = {0,0, 0,0};                  // 对目标心率的单次影响           [下限,上限]
		tragetSpO2[] = {0,0};                     // 对目标心率的单次影响           [下限,上限]

		changeViscosity[] = {0,0};                // 对血液粘度的持续性直接影响     [下限,上限]
		tragetViscosity[] = {0,0};                // 对血液粘度的单次影响           [下限,上限]
		bloodLosing[] = {0,0};                    // 对血液的持续性直接影响         [下限,上限]
	};
	class causeSymptom {
		class Example_2 {                         // 添加新症状的类名
				addPart = "_SAME_";       // 添加新症状的部位
				type = "add";             // 添加新症状的方式
				severityThreshold = 0.2;  // 添加新症状的父症状严重程度阈值
				perAdd = 0.01;            // 每秒添加新症状的值
				repeat = -1;              // 重复方式
			};
	};
	class reduceSymptom {
	};
	class symptomHandlers: symptomHandler {
		ADDON = QFUNC(symptomHandlerExample);     // 症状独立函数
	};
};
```

### causeSymptom/addPart:

`"_SAME_"` 即为与父症状同一位置

`"_ALL_"` 即为所有部位

### causeSymptom/type:

`"add"` 在已有症状的基础上添加 `perAdd` 的值 (如没有已有症状则添加新症状, 严重程度为 `perAdd` 的值)

`"set"` 将已有症状的严重程度设为 `perAdd` 的值 (如没有已有症状则添加新症状, 严重程度为 `perAdd` 的值)

### causeSymptom/repeat:

* [repeat = -1] : 每次父症状的严重程度超过 `severityThreshold` 都会添加症状
* [0 <= repeat < 1] : 每次父症状的严重程度超过 `severityThreshold` 时都有 `repeat` 的概率添加症状
* [repeat < 1] : 父症状的严重程度超过 `severityThreshold` 时 `repeat` - 1 且添加一次症状

### symptomHandlers:

`symptomHandlerExample` 为独立函数的函数名

`[_unit, _symptomClassName, _Part, _severity]` 会传入独立函数

独立函数传回 `exit` 会直接结束 独立函数执行队列 且 **此次修改** 会被放弃

独立函数传回 `[_unit, _symptomClassName, _Part, _severity]` 会覆写原值

独立函数传回 `nil` 会删除症状

## 2.将新症状图标添加至 [symptomIcon](https://github.com/F-Javasparrow/Neurotrauma/tree/master/addons/medical_gui/ui/symptomIcon)

图标格式必须为.paa

长宽比为1:1

**!!!图片分辨率过高会导致在医疗菜单中加载症状时卡顿**
