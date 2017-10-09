unit SortIcon;

interface
 
uses Windows, Messages, CommCtrl;
 
const
SI_Descendign = 0;
SI_Ascendign  = 1;
SI_Erase      = 2;
 
type
  TSortIcon = class
  private
    hListView: THANDLE;
    HDFocus: HD_ITEM;
    FocusIndex: integer;
    OldListViewProc: Pointer;
    function ListViewProc(Handle: HWND; Msg: DWORD; WParam: DWORD; LParam: DWORD): DWORD; stdcall;
  public
    destructor Destroy;
    procedure  SetSortIcon(Value: DWORD);
    procedure  SetHandle(Handle: THANDLE);
  end;
 
implementation
 
 
function DefListViewProc(Handle: HWND; Msg: DWORD; WParam: DWORD; LParam: DWORD): DWORD; stdcall;
var
  pSortIcon: TSortIcon;
begin
  pSortIcon:= TSortIcon(GetWindowLong(Handle, GWL_USERDATA));
  if pSortIcon <> nil then
    Result:= pSortIcon.ListViewProc(Handle, Msg, WParam, LParam)
  else
    Result:= DefWindowProc(Handle, Msg, WParam, LParam);
end;
 
function TSortIcon.ListViewProc(Handle: HWND; Msg: DWORD; WParam: DWORD; LParam: DWORD): DWORD; stdcall;
begin
  if (Msg = WM_NOTIFY) and (LParam <> 0) then
  begin
    if PNMHDR(LParam).code = NM_RELEASEDCAPTURE then
      SendMessage(PNMHDR(LParam).hwndFrom, HDM_SETITEM, FocusIndex, DWORD(@HDFocus));
  end;
  Result:= CallWindowProc(OldListViewProc, Handle, Msg, WParam, LParam);
end;
 
procedure TSortIcon.SetSortIcon(Value: DWORD);
const
  HDF_SORTDOWN = $0200;
  HDF_SORTUP   = $0400;
var
  hHeader: THANDLE;
  HD: HD_ITEM;
  HTI: HD_HITTESTINFO;
  i: integer;
  ColumCount: integer;
  ColumnIndex: integer;
begin
  if (hListView = 0) or (hListView = INVALID_HANDLE_VALUE) then exit;
 
  Windows.GetCursorPos(HTI.Point);
  Windows.ScreenToClient(hListView, HTI.Point);
  hHeader:= SendMessage(hListView, LVM_GETHEADER, 0, 0);
  ColumCount:= SendMessage(hHeader, HDM_GETITEMCOUNT, 0, 0);
  ColumnIndex:= SendMessage(hHeader, HDM_HITTEST, 0, DWORD(@HTI));
  if HTI.flags <> HHT_ONDIVIDER then FocusIndex:= ColumnIndex;
 
  for i:= 0 to ColumCount - 1 do
  begin
    HD.mask:= HDI_FORMAT;
    SendMessage(hHeader, HDM_GETITEM, i, Integer(@HD));
    if i = FocusIndex then
    begin
      if Value = SI_Ascendign then
        HD.fmt:= (HD.fmt and not HDF_SORTDOWN) or HDF_SORTUP
      else if Value = SI_Descendign then
        HD.fmt:= (HD.fmt and not HDF_SORTUP) or HDF_SORTDOWN;
      HDFocus:= HD;
    end
    else
      // borra la flechita de los demás...
      HD.fmt:= HD.fmt and not(HDF_SORTUP or HDF_SORTDOWN);
    SendMessage(hHeader, HDM_SETITEM, i, Integer(@HD));
  end;
end;
 
procedure TSortIcon.SetHandle(Handle: THANDLE);
begin
  if (hListView <> 0) or (Handle = INVALID_HANDLE_VALUE) or (Handle = 0) then
  if hListView <> 0 then
  begin
    SetWindowLong(hListView, GWL_USERDATA, 0);
    SetWindowLong(hListView, GWL_WNDPROC, LongInt(OldListViewProc));
    SetSortIcon(SI_Erase);
    hListView:= 0;
  end;
 
  if (Handle <> INVALID_HANDLE_VALUE) and (Handle <> 0) then
  begin
    hListView:= Handle;
    SetWindowLong(hListView, GWL_USERDATA, LongInt(self));
    OldListViewProc:= Pointer(SetWindowLong(hListView, GWL_WNDPROC, LongInt(@DefListViewProc)));
  end;
end;
 
destructor TSortIcon.Destroy;
begin
  SetHandle(0);
end;
 
end.
