COMMON_SRC_DIR = src/common


MYSITE_SRC_DIR = src/mysite

MYSITE_DEST = $(ALL_DEST_BASE)/mysite

MYSITE_TARGETS = $(MYSITE_DEST) $(MYSITE_DIRS_DEST) $(MYSITE_COMMON_DIRS_DEST) $(MYSITE_COMMON_IMAGES_DEST) $(MYSITE_IMAGES_DEST) $(MYSITE_DOCS_DEST)
        
MYSITE_WML_FLAGS = $(WML_FLAGS) -DLATEMP_SERVER=mysite

MYSITE_DOCS_DEST = $(patsubst %,$(MYSITE_DEST)/%,$(MYSITE_DOCS))

MYSITE_DIRS_DEST = $(patsubst %,$(MYSITE_DEST)/%,$(MYSITE_DIRS))

MYSITE_IMAGES_DEST = $(patsubst %,$(MYSITE_DEST)/%,$(MYSITE_IMAGES))

MYSITE_COMMON_IMAGES_DEST = $(patsubst %,$(MYSITE_DEST)/%,$(COMMON_IMAGES))

MYSITE_COMMON_DIRS_DEST = $(patsubst %,$(MYSITE_DEST)/%,$(COMMON_DIRS))
        
$(MYSITE_DOCS_DEST) :: $(MYSITE_DEST)/% : $(MYSITE_SRC_DIR)/%.wml $(DOCS_COMMON_DEPS) 
	( cd $(MYSITE_SRC_DIR) && wml $(MYSITE_WML_FLAGS) -DLATEMP_FILENAME=$(patsubst $(MYSITE_DEST)/%,%,$(patsubst %.wml,%,$@)) $(patsubst $(MYSITE_SRC_DIR)/%,%,$<) ) > $@

$(MYSITE_DIRS_DEST) :: $(MYSITE_DEST)/% : unchanged
	mkdir -p $@
	touch $@

$(MYSITE_IMAGES_DEST) :: $(MYSITE_DEST)/% : $(MYSITE_SRC_DIR)/%
	cp -f $< $@

$(MYSITE_COMMON_IMAGES_DEST) :: $(MYSITE_DEST)/% : $(COMMON_SRC_DIR)/%
	cp -f $< $@

$(MYSITE_COMMON_DIRS_DEST)  :: $(MYSITE_DEST)/% : unchanged
	mkdir -p $@
	touch $@

$(MYSITE_DEST): unchanged
	mkdir -p $@
	touch $@
 
latemp_targets: $(MYSITE_TARGETS)

