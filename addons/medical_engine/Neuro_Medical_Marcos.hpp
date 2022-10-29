#define GET_NUMBER(config,default) (if (isNumber (config)) then {getNumber (config)} else {default})
#define GET_STRING(config,default) (if (isText (config)) then {getText (config)} else {default})
#define GET_ARRAY(config,default) (if (isArray (config)) then {getArray (config)} else {default})

// 心率&血压&血氧
#define GETHR(var1) var1 getVariable [QEGVAR(medical,HR),80]
#define GETRR(var1) var1 getVariable [QEGVAR(medical,RR),[80,100]]
#define GETSPO2(var1) var1 getVariable [QEGVAR(medical,SpO2),100]

#define SETHR(var1,var2) var1 setVariable [QEGVAR(medical,HR),var2]
#define SETRR(var1,var2) var1 setVariable [QEGVAR(medical,RR),var2]
#define SETSPO2(var1,var2) var1 setVariable [QEGVAR(medical,SpO2),var2]


#define GETHR_T(var1) var1 getVariable [QEGVAR(medical,HR_Target),80]
#define GETRR_T(var1) var1 getVariable [QEGVAR(medical,RR_Target),[80,100]]
#define GETSPO2_T(var1) var1 getVariable [QEGVAR(medical,SpO2),100]

#define SETHR_T(var1,var2) var1 setVariable [QEGVAR(medical,HR_Target),var2]
#define SETRR_T(var1,var2) var1 setVariable [QEGVAR(medical,RR_Target),var2]
#define SETSPO2_T(var1,var2) var1 setVariable [QEGVAR(medical,SpO2_Target),var2]

// 其他
#define GETBLOODVOLUME(var1) var1 getVariable [QEGVAR(medical,BloodVolume),6000]
#define SETBLOODVOLUME(var1,var2) var1 setVariable [QEGVAR(medical,BloodVolume),var2]