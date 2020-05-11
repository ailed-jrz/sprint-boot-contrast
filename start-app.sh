#!/bin/bash

if [[ "$START_WITH_CONTRAST" = true ]]; then
  echo "Adding Contrast agent"
  java -Dcontrast.config.path=contrast_security.yaml  -javaagent:contrast.jar -jar sprint-boot-contrast.jar
else
  echo "Starting without Contrast"
  java -jar sprint-boot-contrast.jar
fi