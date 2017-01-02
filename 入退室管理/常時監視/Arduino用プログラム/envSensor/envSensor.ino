/*******************************************************************************
*  電源が入ると，一定時間間隔でセンサ処理を行い，処理結果をシリアルコンソールで
*  外部に送信するプログラム
*******************************************************************************/


/*******************************************************************************
*  機能のON/OFFなど
*******************************************************************************/
// 特に無し
//#define DEBUG
#define DOOR_SENSOR
#define ANALOG_LIGHT_SENSOR // Grove光センサ利用の場合
//#define TSL2561_LIGHT_SENSOR // Grove I2Cデジタル光センサ利用の場合
#define REQUEST_SENSOR  // シリアルに何か書き込みがあるとセンシングする機能
//#define LOOP_SENSOR      // 一定時間間隔でセンシングする機能
/*******************************************************************************
*  ピン番号の指定
*******************************************************************************/
/* 温度・湿度センサの接続先ピン(センサ処理の例のため) */
#define DHT_PIN 2            // DHTシリーズの温湿度センサを接続するピン番号
#ifdef ANALOG_LIGHT_SENSOR
#define LIGHT_SENSOR_PIN 0   // 光センサのピン番号 (A0)
#endif /* ANALOG_LIGHT_SENSOR */
#define SWITCH_PIN 4         // リードスイッチのピン番号
/*******************************************************************************
*  定数の指定
*******************************************************************************/
#ifdef DEBUG
#define INTERVAL 5000    // 温湿度と光センサのデータを読み取る間隔(単位ms)
#else
#define INTERVAL 300000    // 温湿度と光センサのデータを読み取る間隔(単位ms)
#endif /* DEBUG */
/*******************************************************************************
*  センサ関係処理
*  注意事項 :
*    ・本来この部分はユーザが開発する
*    ・DHTシリーズのセンサを用いるこのプログラムはあくまでサンプル
*    ・今回使うのはDHTシリーズセンサ用ライブラリのうち，https://github.com/markruys/arduino-DHT
*******************************************************************************/
#include "DHT.h"

DHT dht;
#ifdef LOOP_SENSOR
unsigned long lastTime;
#endif /* LOOP_SENSOR */
#ifdef DOOR_SENSOR
int lastStatus=0;
#endif /* DOOR_SENSOR */

#ifdef TSL2561_LIGHT_SENSOR
#include <Wire.h>
#include <Digital_Light_TSL2561.h>
#endif /* TSL2561_LIGHT_SENSOR */

/* センサの起動時の初期化処理 */
void setupSensor()
{
#ifdef TSL2561_LIGHT_SENSOR
  Wire.begin();
  TSL2561.init();
#endif /* TSL2561_LIGHT_SENSOR */
  dht.setup(DHT_PIN); // DHTをセットアップ
#ifdef DOOR_SENSOR
  pinMode(SWITCH_PIN, INPUT);
#endif /* DOOR_SENSOR */
#ifdef DEBUG
#ifdef DOOR_SENSOR
  Serial.println("Status\tLight\tHumidity (%)\tTemperature (C)\t(F)\tdoor");
#else /* DOOR_SENSOR */
  Serial.println("Status\tLight\tHumidity (%)\tTemperature (C)\t(F)");
#endif /* DOOR_SENSOR */
#endif /* DEBUG */
}

#ifdef DOOR_SENSOR
void doorSensor(int pin){
  int doorStatus=digitalRead(pin);
  if (0==doorStatus) {
    Serial.print("open");
  } else {
    Serial.print("close");
  }
}
void checkDoorEvent(int pin){
  int doorStatus=digitalRead(pin);

  if ((0==doorStatus) && (1==lastStatus)) {
    Serial.println("open");
  }
  if ((1==doorStatus) && (0==lastStatus)) {
    Serial.println("close");
  }
  lastStatus=doorStatus;
}
#endif /* DOOR_SENSOR */

/* センサ処理 */
void getSensorValue(){
  delay(dht.getMinimumSamplingPeriod());
  float humidity = dht.getHumidity();
  float temperature = dht.getTemperature();
#ifdef DEBUG
  Serial.println("read dht value .. done");
#endif /* DEBUG */
#ifdef ANALOG_LIGHT_SENSOR
  int light_value = analogRead(LIGHT_SENSOR_PIN);
#endif /* ANALOG_LIGHT_SENSOR */
#ifdef TSL2561_LIGHT_SENSOR
  unsigned long light_value=TSL2561.readVisibleLux();
#endif /* TSL2561_LIGHT_SENSOR */
#ifdef DEBUG
  Serial.println("read light sensor value .. done");
#endif /* DEBUG */

  Serial.print(dht.getStatusString());
  Serial.print("\t");
  Serial.print(light_value);
  Serial.print("\t");
  Serial.print(humidity, 1);
  Serial.print("\t\t");
  Serial.print(temperature, 1);
  Serial.print("\t\t");
#ifdef DOOR_SENSOR
  Serial.print(dht.toFahrenheit(temperature), 1);
  Serial.print("\t");
  doorSensor(SWITCH_PIN);
  Serial.println("");
#else /* DOOR_SENSOR */
  Serial.println(dht.toFahrenheit(temperature), 1);
#endif /* DOOR_SENSOR */
}

/* リセット処理 */
void(* resetFunc) (void) = 0;//declare reset function at address 0
/*******************************************************************************
*  ここからプログラム本体
*******************************************************************************/
/*******************************************************************************
*  各種定義
*******************************************************************************/
// 特になし

/*******************************************************************************
*  初期化処理
*******************************************************************************/
void setup()
{
  Serial.begin(9600);
  Serial.println();
  setupSensor();
  getSensorValue();
#ifdef LOOP_SENSOR
  lastTime=millis();
#endif /* LOOP_SENSOR */
}


/*******************************************************************************
*  ループ
*******************************************************************************/
void loop()
{
#ifdef LOOP_SENSOR
  unsigned long timeDiff=millis()-lastTime;
#endif /* LOOP_SENSOR */
#ifdef DOOR_SENSOR
  checkDoorEvent(SWITCH_PIN);
#endif /* DOOR_SENSOR */
#ifdef LOOP_SENSOR
  if (timeDiff > INTERVAL ) {
    lastTime=millis();
    getSensorValue();
  }
#endif /* LOOP_SENSOR */

#ifdef REQUEST_SENSOR
  // send data only when you receive data:
  if (Serial.available() > 0) {
    char incomingByte = 0;
    // read the incoming byte:
    incomingByte = Serial.read();
    if( incomingByte == 'r' ) {
        resetFunc();
    } else {
        getSensorValue();
    }
  }
#endif /* REQUEST_SENSOR */
}

