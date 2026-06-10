# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution has no build errors following the transformation. The project `GadgetsOnline/GadgetsOnline.csproj` compiled successfully, which indicates the migration to cross-platform .NET has completed without introducing any compilation failures.

## Validation Steps

### 1. Review the Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `TargetFramework` is set to the intended cross-platform version, for example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is still referencing a Windows-only TFM (e.g., `net472` or `net48`), update it to the appropriate `net6.0`, `net7.0`, or `net8.0` target.

### 2. Restore and Build Locally

Run the following commands from the solution root to confirm a clean restore and build:

```bash
dotnet restore
dotnet build --configuration Release
```

Ensure there are no warnings that could indicate deprecated APIs or platform-specific code paths that may fail at runtime.

### 3. Run the Test Suite

If the solution contains a test project, execute the tests to verify runtime behavior has not regressed:

```bash
dotnet test --configuration Release
```

Review any failing tests and trace them back to code that may have changed behavior between .NET Framework and modern .NET.

### 4. Check for Windows-Specific Dependencies

Inspect `GadgetsOnline.csproj` and any referenced libraries for NuGet packages that are Windows-only. Common examples include:

- `System.Web` (not available on cross-platform .NET)
- `Microsoft.Web.Infrastructure`
- Any COM interop or P/Invoke calls targeting Windows APIs

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `dotnet-compatibility` tool to surface any remaining platform-specific API usage:

```bash
dotnet tool install -g dotnet-compatibility
```

### 5. Verify Runtime Behavior

Start the application and exercise its primary workflows manually or through integration tests:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Pay particular attention to:

- Database connectivity and any Entity Framework migrations
- Authentication and session management, which often changes between ASP.NET and ASP.NET Core
- File system paths that may use hardcoded Windows-style separators (`\`) instead of `Path.Combine` or forward slashes

### 6. Inspect Configuration Files

Confirm that `web.config` or `app.config` settings have been migrated to `appsettings.json` where applicable. ASP.NET Core does not process `web.config` for application configuration (it is only used by IIS for hosting settings).

### 7. Review Middleware and HTTP Pipeline

If this is a web project, verify that all former `HttpModule` and `HttpHandler` registrations have been replaced with the equivalent ASP.NET Core middleware in `Program.cs` or `Startup.cs`.

### 8. Test on a Non-Windows Platform (Optional but Recommended)

To confirm true cross-platform compatibility, run the application on Linux or macOS:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

This will surface any remaining OS-specific assumptions in the code.

## Deployment

Once the above validation steps pass:

1. Publish a self-contained or framework-dependent release build:

```bash
# Framework-dependent
dotnet publish GadgetsOnline/GadgetsOnline.csproj -c Release -o ./publish

# Self-contained (example for Linux x64)
dotnet publish GadgetsOnline/GadgetsOnline.csproj -c Release -r linux-x64 --self-contained true -o ./publish
```

2. Verify the contents of the `./publish` folder contain all expected assemblies and configuration files.

3. Deploy the contents of the `./publish` folder to the target host environment and confirm the application starts and responds correctly.