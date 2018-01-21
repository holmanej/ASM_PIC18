#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
endif
endif

# Environment
MKDIR=gnumkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=cof
DEBUGGABLE_SUFFIX=cof
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/ASM_PIC18.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=cof
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/ASM_PIC18.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

ifeq ($(COMPARE_BUILD), true)
COMPARISON_BUILD=
else
COMPARISON_BUILD=
endif

ifdef SUB_IMAGE_ADDRESS

else
SUB_IMAGE_ADDRESS_COMMAND=
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=Main.asm CoreFunctions.asm ISR.asm PT6961.asm SPI.asm

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/Main.o ${OBJECTDIR}/CoreFunctions.o ${OBJECTDIR}/ISR.o ${OBJECTDIR}/PT6961.o ${OBJECTDIR}/SPI.o
POSSIBLE_DEPFILES=${OBJECTDIR}/Main.o.d ${OBJECTDIR}/CoreFunctions.o.d ${OBJECTDIR}/ISR.o.d ${OBJECTDIR}/PT6961.o.d ${OBJECTDIR}/SPI.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/Main.o ${OBJECTDIR}/CoreFunctions.o ${OBJECTDIR}/ISR.o ${OBJECTDIR}/PT6961.o ${OBJECTDIR}/SPI.o

# Source Files
SOURCEFILES=Main.asm CoreFunctions.asm ISR.asm PT6961.asm SPI.asm


CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/ASM_PIC18.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=18f14k22
MP_LINKER_DEBUG_OPTION=-r=ROM@0x3E00:0x3FFF 
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/Main.o: Main.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/Main.o.d 
	@${RM} ${OBJECTDIR}/Main.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/Main.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PK3=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/Main.lst\" -e\"${OBJECTDIR}/Main.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/Main.o\" \"Main.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/Main.o"
	@${FIXDEPS} "${OBJECTDIR}/Main.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/CoreFunctions.o: CoreFunctions.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/CoreFunctions.o.d 
	@${RM} ${OBJECTDIR}/CoreFunctions.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/CoreFunctions.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PK3=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/CoreFunctions.lst\" -e\"${OBJECTDIR}/CoreFunctions.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/CoreFunctions.o\" \"CoreFunctions.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/CoreFunctions.o"
	@${FIXDEPS} "${OBJECTDIR}/CoreFunctions.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/ISR.o: ISR.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/ISR.o.d 
	@${RM} ${OBJECTDIR}/ISR.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/ISR.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PK3=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/ISR.lst\" -e\"${OBJECTDIR}/ISR.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/ISR.o\" \"ISR.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/ISR.o"
	@${FIXDEPS} "${OBJECTDIR}/ISR.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/PT6961.o: PT6961.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/PT6961.o.d 
	@${RM} ${OBJECTDIR}/PT6961.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/PT6961.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PK3=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/PT6961.lst\" -e\"${OBJECTDIR}/PT6961.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/PT6961.o\" \"PT6961.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/PT6961.o"
	@${FIXDEPS} "${OBJECTDIR}/PT6961.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/SPI.o: SPI.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/SPI.o.d 
	@${RM} ${OBJECTDIR}/SPI.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/SPI.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PK3=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/SPI.lst\" -e\"${OBJECTDIR}/SPI.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/SPI.o\" \"SPI.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/SPI.o"
	@${FIXDEPS} "${OBJECTDIR}/SPI.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
else
${OBJECTDIR}/Main.o: Main.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/Main.o.d 
	@${RM} ${OBJECTDIR}/Main.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/Main.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/Main.lst\" -e\"${OBJECTDIR}/Main.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/Main.o\" \"Main.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/Main.o"
	@${FIXDEPS} "${OBJECTDIR}/Main.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/CoreFunctions.o: CoreFunctions.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/CoreFunctions.o.d 
	@${RM} ${OBJECTDIR}/CoreFunctions.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/CoreFunctions.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/CoreFunctions.lst\" -e\"${OBJECTDIR}/CoreFunctions.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/CoreFunctions.o\" \"CoreFunctions.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/CoreFunctions.o"
	@${FIXDEPS} "${OBJECTDIR}/CoreFunctions.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/ISR.o: ISR.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/ISR.o.d 
	@${RM} ${OBJECTDIR}/ISR.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/ISR.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/ISR.lst\" -e\"${OBJECTDIR}/ISR.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/ISR.o\" \"ISR.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/ISR.o"
	@${FIXDEPS} "${OBJECTDIR}/ISR.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/PT6961.o: PT6961.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/PT6961.o.d 
	@${RM} ${OBJECTDIR}/PT6961.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/PT6961.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/PT6961.lst\" -e\"${OBJECTDIR}/PT6961.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/PT6961.o\" \"PT6961.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/PT6961.o"
	@${FIXDEPS} "${OBJECTDIR}/PT6961.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/SPI.o: SPI.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/SPI.o.d 
	@${RM} ${OBJECTDIR}/SPI.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/SPI.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/SPI.lst\" -e\"${OBJECTDIR}/SPI.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/SPI.o\" \"SPI.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/SPI.o"
	@${FIXDEPS} "${OBJECTDIR}/SPI.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/ASM_PIC18.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    LinkerFile.lkr
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_LD} $(MP_EXTRA_LD_PRE) "LinkerFile.lkr"  -p$(MP_PROCESSOR_OPTION)  -w -x -u_DEBUG -z__ICD2RAM=1 -m"${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map"   -z__MPLAB_BUILD=1  -z__MPLAB_DEBUG=1 -z__MPLAB_DEBUGGER_PK3=1 $(MP_LINKER_DEBUG_OPTION) -odist/${CND_CONF}/${IMAGE_TYPE}/ASM_PIC18.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}     
else
dist/${CND_CONF}/${IMAGE_TYPE}/ASM_PIC18.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   LinkerFile.lkr
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_LD} $(MP_EXTRA_LD_PRE) "LinkerFile.lkr"  -p$(MP_PROCESSOR_OPTION)  -w  -m"${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map"   -z__MPLAB_BUILD=1  -odist/${CND_CONF}/${IMAGE_TYPE}/ASM_PIC18.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}     
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r build/default
	${RM} -r dist/default

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
