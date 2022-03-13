# Levovo-K29-K49-E49-Marker-Slic2.1

主要用于安装系统时开启**Secure Boot**后，开机无法进入**Bios**使用，

![IMG_2692](https://user-images.githubusercontent.com/86851841/158040660-d68929f8-aa4d-44c9-b4af-2203400561e7.JPG)

主要是清除Slic

**其它机型是否支持，并不清楚**无法测试，

我的电脑型号是K29每次无法进入Bios后我都需要使用此工具，

用纯DOS U盘启动后进入相应的目录，

输入：`A.bat`后按提示操作，

```
1.Write MB 11S-(Only For K49/E49/K29)
2.Write Machine SSN
3.Write UUID Manul
4.Write UUID AUTO
5.Slp2 Enable
6.Slp2 Disable
7.Clear EEPROM(clear all SN)
8.Exit
```

按`1`后写入主板上白色纸条上的`11S`完整信息

SN清除后可以设置为自定义信息，

![IMG_2691](https://user-images.githubusercontent.com/86851841/158040800-7b6e122f-892b-4d1b-b65e-ddaee5e29794.JPG)

