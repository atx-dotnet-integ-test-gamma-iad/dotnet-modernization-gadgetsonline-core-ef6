# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

The transformation of your solution to cross-platform .NET appears to have completed successfully. No build errors were detected in any of the projects within the solution.

## Validation

### 1. Restore Dependencies
Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

### 2. Build the Solution
Confirm the solution builds cleanly in Release configuration:

```bash
dotnet build --configuration Release
```

Review the output for any warnings that, while non-blocking, may indicate deprecated APIs or compatibility concerns worth addressing.

### 3. Run Unit Tests
If the solution contains any test projects, execute them to verify existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review test results and investigate any failures before proceeding.

### 4. Run the Application Locally
Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Walk through the core application workflows manually to confirm expected behavior, including:
- Page rendering and navigation
- Database connectivity and data retrieval
- Any authentication or authorization flows
- Form submissions and data writes

### 5. Review Configuration Files
Check `appsettings.json` (and environment-specific variants such as `appsettings.Development.json`) to ensure:
- Connection strings are correct for your target environment
- Any keys or settings previously stored in `Web.config` have been properly migrated
- Logging configuration is appropriate

### 6. Check for Remaining `Web.config` Dependencies
Verify that no runtime behavior still depends on `Web.config` entries that may not have been migrated, such as:
- HTTP handlers or modules
- Custom error pages
- URL rewrite rules

These should now be handled in `Program.cs` or `Startup.cs` using the appropriate ASP.NET Core middleware.

### 7. Review Static Files and wwwroot
Confirm that all static assets (CSS, JavaScript, images) are located under the `wwwroot` folder and are being served correctly when the application runs.

### 8. Verify Target Framework
Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to your intended version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

## Deployment

### 1. Publish the Application
Use the `dotnet publish` command to produce deployment artifacts:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

### 2. Verify the Publish Output
Inspect the `./publish` directory to confirm all expected files are present, including the compiled assembly, static assets, and configuration files.

### 3. Deploy to Target Environment
Copy the contents of the `./publish` directory to your target server or hosting environment. Ensure the target machine has the appropriate .NET runtime installed:

```bash
dotnet --list-runtimes
```

The required runtime version should match the `<TargetFramework>` specified in the project file.

### 4. Confirm Environment-Specific Configuration
On the target environment, set the `ASPNETCORE_ENVIRONMENT` environment variable appropriately (e.g., `Production`) and verify that the correct `appsettings` file is being loaded.