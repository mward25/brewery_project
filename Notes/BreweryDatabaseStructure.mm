<map version="freeplane 1.9.8">
<!--To view this file, download free mind mapping software Freeplane from https://www.freeplane.org -->
<node TEXT="BreweryDatabaseStructure" FOLDED="false" ID="ID_696401721" CREATED="1610381621824" MODIFIED="1636927934402" STYLE="oval">
<font SIZE="18"/>
<hook NAME="MapStyle" zoom="1.21">
    <properties fit_to_viewport="false" edgeColorConfiguration="#808080ff,#ff0000ff,#0000ffff,#00ff00ff,#ff00ffff,#00ffffff,#7c0000ff,#00007cff,#007c00ff,#7c007cff,#007c7cff,#7c7c00ff" associatedTemplateLocation="template:/standard-1.6.mm" show_icon_for_attributes="true" show_note_icons="true"/>

<map_styles>
<stylenode LOCALIZED_TEXT="styles.root_node" STYLE="oval" UNIFORM_SHAPE="true" VGAP_QUANTITY="24 pt">
<font SIZE="24"/>
<stylenode LOCALIZED_TEXT="styles.predefined" POSITION="right" STYLE="bubble">
<stylenode LOCALIZED_TEXT="default" ID="ID_271890427" ICON_SIZE="12 pt" COLOR="#000000" STYLE="fork">
<arrowlink SHAPE="CUBIC_CURVE" COLOR="#000000" WIDTH="2" TRANSPARENCY="200" DASH="" FONT_SIZE="9" FONT_FAMILY="SansSerif" DESTINATION="ID_271890427" STARTARROW="DEFAULT" ENDARROW="NONE"/>
<font NAME="SansSerif" SIZE="10" BOLD="false" ITALIC="false"/>
<richcontent CONTENT-TYPE="plain/auto" TYPE="DETAILS"/>
<richcontent TYPE="NOTE" CONTENT-TYPE="plain/auto"/>
</stylenode>
<stylenode LOCALIZED_TEXT="defaultstyle.details"/>
<stylenode LOCALIZED_TEXT="defaultstyle.attributes">
<font SIZE="9"/>
</stylenode>
<stylenode LOCALIZED_TEXT="defaultstyle.note" COLOR="#000000" BACKGROUND_COLOR="#ffffff" TEXT_ALIGN="LEFT"/>
<stylenode LOCALIZED_TEXT="defaultstyle.floating">
<edge STYLE="hide_edge"/>
<cloud COLOR="#f0f0f0" SHAPE="ROUND_RECT"/>
</stylenode>
<stylenode LOCALIZED_TEXT="defaultstyle.selection" BACKGROUND_COLOR="#4e85f8" BORDER_COLOR_LIKE_EDGE="false" BORDER_COLOR="#4e85f8"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.user-defined" POSITION="right" STYLE="bubble">
<stylenode LOCALIZED_TEXT="styles.topic" COLOR="#18898b" STYLE="fork">
<font NAME="Liberation Sans" SIZE="10" BOLD="true"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.subtopic" COLOR="#cc3300" STYLE="fork">
<font NAME="Liberation Sans" SIZE="10" BOLD="true"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.subsubtopic" COLOR="#669900">
<font NAME="Liberation Sans" SIZE="10" BOLD="true"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.important" ID="ID_67550811">
<icon BUILTIN="yes"/>
<arrowlink COLOR="#003399" TRANSPARENCY="255" DESTINATION="ID_67550811"/>
</stylenode>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.AutomaticLayout" POSITION="right" STYLE="bubble">
<stylenode LOCALIZED_TEXT="AutomaticLayout.level.root" COLOR="#000000" STYLE="oval" SHAPE_HORIZONTAL_MARGIN="10 pt" SHAPE_VERTICAL_MARGIN="10 pt">
<font SIZE="18"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,1" COLOR="#0033ff">
<font SIZE="16"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,2" COLOR="#00b439">
<font SIZE="14"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,3" COLOR="#990000">
<font SIZE="12"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,4" COLOR="#111111">
<font SIZE="10"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,5"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,6"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,7"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,8"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,9"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,10"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,11"/>
</stylenode>
</stylenode>
</map_styles>
</hook>
<hook NAME="AutomaticEdgeColor" COUNTER="21" RULE="ON_BRANCH_CREATION"/>
<node TEXT="Ingredient" POSITION="right" ID="ID_1681418182" CREATED="1636926633498" MODIFIED="1636927777572">
<edge COLOR="#ff0000"/>
<node TEXT="IngredientID" ID="ID_1414326089" CREATED="1636927309058" MODIFIED="1636927797815">
<node TEXT="Name" ID="ID_1633401040" CREATED="1636927778380" MODIFIED="1636927807100"/>
</node>
</node>
<node TEXT="BrewHistory" POSITION="right" ID="ID_996134013" CREATED="1636926727577" MODIFIED="1636927934402" HGAP_QUANTITY="17 pt" VSHIFT_QUANTITY="9.75 pt">
<edge COLOR="#7c007c"/>
<node TEXT="BrewID" ID="ID_809923225" CREATED="1636927292428" MODIFIED="1636927304508"/>
</node>
<node TEXT="Brew" POSITION="right" ID="ID_1534727686" CREATED="1636929546897" MODIFIED="1636929548701">
<edge COLOR="#007c7c"/>
</node>
<node TEXT="Recipe" POSITION="right" ID="ID_485700976" CREATED="1636926674899" MODIFIED="1636927427761">
<edge COLOR="#00ffff"/>
<node TEXT="RecipeID" ID="ID_1528673226" CREATED="1636927512677" MODIFIED="1636927514961">
<node TEXT="RecipeIngredientsID" ID="ID_1929030746" CREATED="1636928292458" MODIFIED="1636928299713">
<node TEXT="Style" ID="ID_1229637434" CREATED="1636928742539" MODIFIED="1636928792354"/>
</node>
</node>
</node>
<node TEXT="RecipeIngredients" POSITION="right" ID="ID_1435504095" CREATED="1636928217346" MODIFIED="1636928232151">
<edge COLOR="#00007c"/>
<node TEXT="RecipeIngredientsID" ID="ID_1968771562" CREATED="1636928239594" MODIFIED="1636928246489">
<node TEXT="Ingredient" ID="ID_1603417074" CREATED="1636928252530" MODIFIED="1636928269407">
<node TEXT="Amount" ID="ID_176606754" CREATED="1636928426098" MODIFIED="1636928429309"/>
</node>
</node>
</node>
</node>
</map>
